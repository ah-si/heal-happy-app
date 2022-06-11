import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

String _getBaseUrl() {
  final baseUri = Uri.base;
  //baseUri.port > 5000 mean we Run flutter app in IDE, not included in server side so use URL server, use http to avoid self signed cert issues
  if (baseUri.port > 5000 || !kIsProductionMode) {
    return 'https://devs.ah-si.org';
  }
  // if not on web use normal URL
  if (baseUri.scheme.contains('file')) {
    return HealHappySdk.basePath;
  }
  var port = '';
  if (baseUri.port != 443) {
    port = ':${baseUri.port}';
  }
  return baseUri.scheme + '://' + baseUri.host + port;
}

class Config {
  static Config? _singleton;

  static Config? get instance => _singleton;

  final String baseUrl;

  factory Config({String? baseUrl}) => _singleton ??= Config._instance(baseUrl: baseUrl ?? _getBaseUrl());

  const Config._instance({required this.baseUrl});
}
