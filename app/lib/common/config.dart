import 'package:heal_happy_sdk/heal_happy_sdk.dart';

String _getBaseUrl() {
  final baseUri = Uri.base;
  //baseUri.port > 5000 mean we Run flutter app in IDE, not included in server side so use URL server
  if (baseUri.scheme.contains('file') || baseUri.port > 5000) {
    return HealHappySdk.basePath;
  }
  return baseUri.scheme + '://' + baseUri.host + ':' + baseUri.port.toString();
}

class Config {
  static Config? _singleton;

  static Config? get instance => _singleton;

  final String baseUrl;

  factory Config({String? baseUrl}) => _singleton ??= Config._instance(baseUrl: baseUrl ?? _getBaseUrl());

  const Config._instance({required this.baseUrl});
}
