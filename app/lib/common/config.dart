
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

class Config {
  static Config? _singleton;
  static Config? get instance => _singleton;

  final String baseUrl;

  factory Config({String baseUrl = HealHappySdk.basePath}) => _singleton ?? Config._instance(baseUrl: baseUrl);

  const Config._instance({this.baseUrl = HealHappySdk.basePath});
}
