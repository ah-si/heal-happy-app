import 'package:flutter/material.dart';
import 'package:heal_happy/common/l10n/common_localizations.dart';
import 'package:heal_happy/common/l10n/error_localizations.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/diacritic_replacement_map.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

extension HealerStatsExtension on HealerStats {
  String get name => '$firstName $lastName';

  String get adminAddress {
    String address = '';
    address = street.isNullOrEmpty ? '' : '$street\n';
    address += street2.isNullOrEmpty ? '' : '$street2\n';
    address += '$zipCode $city';
    return address;
  }
}

extension DateTimeExtention on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime.utc(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

extension UserExtension on User {
  String get name => '$firstName $lastName';

  bool get _canJoinHealerTelegram => [
        'cardiologue',
        'chir_dentiste',
        'med_gene',
        'psychiatre',
        'psychiatre_enfant_ado',
        'spe_med_interne',
        'spe_med_exper',
        'spe_med_readaptation',
        'spe_med_readaptation',
      ].contains(job);

  String get telegramUrl => _canJoinHealerTelegram ? kUrlTelegramHealer : kUrlTelegramPara;

  String get adminAddress {
    String address = '';
    address = street.isNullOrEmpty ? '' : '$street\n';
    address += street2.isNullOrEmpty ? '' : '$street2\n';
    address += '$zipCode $city';
    return address;
  }
}

extension HealerExtension on Healer {
  String get address {
    String address = '';
    if (isAddressPublic) {
      address = street.isNullOrEmpty ? '' : '$street\n';
      address += street2.isNullOrEmpty ? '' : '$street2\n';
    }
    address += '$zipCode $city';
    return address;
  }

  String get name => '$firstName $lastName.';
}

extension ContextExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  CommonLocalizations get l10n => CommonLocalizations.of(this);

  ErrorLocalizations get el10n => ErrorLocalizations.of(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  Color get primaryColor => kPrimaryColor;

  Color get accentColor => kAccentColor;

  bool isRelevant() {
    try {
      navigator;
      return true;
    } catch (_) {
      return false;
    }
  }
}

extension NullStringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension StringCasingExtension on String {
  String get capitalized => length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get titleCase => replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.capitalized).join(" ");

  String removeDiacritic() {
    return String.fromCharCodes(replaceCodeUnits(codeUnits));
  }
}

extension TimeOfDayExtension on TimeOfDay {
  bool isAfter(TimeOfDay? other) {
    if (other == null) return false;
    if (hour < other.hour) {
      return false;
    }
    return minute > other.minute;
  }

  bool isBefore(TimeOfDay? other) {
    if (other == null) return false;
    if (hour < other.hour) {
      return true;
    }
    return minute < other.minute;
  }
}
