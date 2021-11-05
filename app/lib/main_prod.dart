

import 'package:heal_happy/common/config.dart';
import 'package:heal_happy/main.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

void main() {
  app(config: Config(baseUrl: HealHappySdk.basePath));
}
