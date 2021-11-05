//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:heal_happy_sdk/src/date_serializer.dart';
import 'package:heal_happy_sdk/src/model/date.dart';

import 'package:heal_happy_sdk/src/model/ask_reset_password.dart';
import 'package:heal_happy_sdk/src/model/calendar_day_settings.dart';
import 'package:heal_happy_sdk/src/model/calendar_settings.dart';
import 'package:heal_happy_sdk/src/model/create_event_request.dart';
import 'package:heal_happy_sdk/src/model/healer.dart';
import 'package:heal_happy_sdk/src/model/healer_availabilities.dart';
import 'package:heal_happy_sdk/src/model/login_request.dart';
import 'package:heal_happy_sdk/src/model/login_response.dart';
import 'package:heal_happy_sdk/src/model/refresh_token_request.dart';
import 'package:heal_happy_sdk/src/model/reset_password.dart';
import 'package:heal_happy_sdk/src/model/user.dart';
import 'package:heal_happy_sdk/src/model/user_all_of.dart';
import 'package:heal_happy_sdk/src/model/user_event.dart';
import 'package:heal_happy_sdk/src/model/user_type_enum.dart';

part 'serializers.g.dart';

@SerializersFor([
  AskResetPassword,
  CalendarDaySettings,
  CalendarSettings,
  CreateEventRequest,
  Healer,
  HealerAvailabilities,
  LoginRequest,
  LoginResponse,
  RefreshTokenRequest,
  ResetPassword,
  User,
  UserAllOf,
  UserEvent,
  UserTypeEnum,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Healer)]),
        () => ListBuilder<Healer>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(UserEvent)]),
        () => ListBuilder<UserEvent>(),
      )
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
