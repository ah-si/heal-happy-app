import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/logging.dart';
import 'package:heal_happy/common/utils/preferences_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:logging/logging.dart';

final apiProvider = Provider<BackendApiProvider>((ref) {
  return BackendApiProvider.setup(
    () => BackendApiProvider().onLogout(),
    PreferencesProvider(),
    baseUrl: HealHappySdk.basePath,
  );
});

class LogoutInterceptor extends Interceptor {
  final VoidCallback onLogout;
  final AuthApi Function() _authApi;
  final PreferencesProvider _preferenceProvider;

  LogoutInterceptor(this.onLogout, this._authApi, this._preferenceProvider);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    //backend tell us our token is not good anymore, let's logout in that case
    if (err.response?.statusCode == 401 && !err.requestOptions.uri.path.contains('/auth/')) {
      /*
      try {
        final result = await _authApi().refreshToken(
            refreshTokenRequest: (RefreshTokenRequestBuilder()
              ..refreshToken = await _preferenceProvider.securePrefs.read(
                key: PreferencesProvider.keyRefreshToken,
              ))
                .build());
        final token = result.data!.token;
        await _preferenceProvider.securePrefs.write(key: PreferencesProvider.keyToken, value: token);
        BackendApiProvider().setToken(token);
        err.requestOptions.headers["Authorization"] = 'Token $token';
        //create request with new access token
        final opts = Options(method: err.requestOptions.method, headers: err.requestOptions.headers);
        final response = await BackendApiProvider().api.dio.request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        return handler.resolve(response);

      } catch (err) {
        _logout(true);
      }

       */
      onLogout();
    } else if (err.response?.statusCode == 401) {
      onLogout();
    }

    handler.next(err);
  }
}

final _logPrint = Logger('network').info;

List<Interceptor> getInterceptors({
  required VoidCallback onLogout,
  required AuthApi Function() authApi,
  required PreferencesProvider preferenceProvider,
}) =>
    kNetworkDebug
        ? [
            ApiKeyAuthInterceptor(),
            LogInterceptor(logPrint: _logPrint, requestBody: true, responseBody: true),
            LogoutInterceptor(
              onLogout,
              authApi,
              preferenceProvider,
            )
          ]
        : <Interceptor>[
            ApiKeyAuthInterceptor(),
            LogoutInterceptor(
              onLogout,
              authApi,
              preferenceProvider,
            )
          ];

class BackendApiProvider {
  static const authKey = 'Bearer';
  final HealHappySdk api;
  late VoidCallback onLogout;

  factory BackendApiProvider() => _singleton;

  BackendApiProvider._(List<Interceptor> interceptors, String baseUrl) : api = HealHappySdk(basePathOverride: baseUrl, interceptors: interceptors);

  String getToken() {
    return (api.dio.interceptors.firstWhere((element) => element is ApiKeyAuthInterceptor) as ApiKeyAuthInterceptor)
        .apiKeys[authKey]!
        .replaceFirst(authKey, '')
        .trim();
  }

  void setToken(String token) {
    api.setApiKey(authKey, '$authKey $token');
  }

  // ignore: prefer_constructors_over_static_methods
  static BackendApiProvider setup(
    VoidCallback onLogout,
    PreferencesProvider preferencesProvider, {
    required String baseUrl,
    List<Interceptor>? interceptors,
  }) {
    interceptors ??= getInterceptors(
      onLogout: onLogout,
      authApi: () => BackendApiProvider().api.getAuthApi(),
      preferenceProvider: preferencesProvider,
    );
    _singleton = BackendApiProvider._(interceptors, baseUrl);
    _singleton.api.dio.options.headers['Accept'] = 'application/json';
    final token = preferencesProvider.prefs.getString(PreferencesProvider.keyToken);

    if (token != null) {
      _singleton.setToken(token);
    }

    // when in debug mode we allow self signed certificates
    if (!kIsProductionMode && !kIsWeb) {
      (_singleton.api.dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (cert, String host, int port) => true;
        return client;
      };
    }
    return _singleton;
  }

  static late BackendApiProvider _singleton;

  static BackendApiProvider get instance => _singleton;
}
