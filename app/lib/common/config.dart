


class Config {
  static Config? _singleton;
  static Config? get instance => _singleton;

  final String baseUrl;

  factory Config({String baseUrl = '/'}) => _singleton ??= Config._instance(baseUrl: baseUrl);

  const Config._instance({this.baseUrl = '/'});
}
