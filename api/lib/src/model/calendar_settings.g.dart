// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_settings.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CalendarSettings extends CalendarSettings {
  @override
  final CalendarDaySettings? monday;
  @override
  final CalendarDaySettings? tuesday;
  @override
  final CalendarDaySettings? wednesday;
  @override
  final CalendarDaySettings? thursday;
  @override
  final CalendarDaySettings? friday;
  @override
  final CalendarDaySettings? saturday;
  @override
  final CalendarDaySettings? sunday;

  factory _$CalendarSettings(
          [void Function(CalendarSettingsBuilder)? updates]) =>
      (new CalendarSettingsBuilder()..update(updates)).build();

  _$CalendarSettings._(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday})
      : super._();

  @override
  CalendarSettings rebuild(void Function(CalendarSettingsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CalendarSettingsBuilder toBuilder() =>
      new CalendarSettingsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CalendarSettings &&
        monday == other.monday &&
        tuesday == other.tuesday &&
        wednesday == other.wednesday &&
        thursday == other.thursday &&
        friday == other.friday &&
        saturday == other.saturday &&
        sunday == other.sunday;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, monday.hashCode), tuesday.hashCode),
                        wednesday.hashCode),
                    thursday.hashCode),
                friday.hashCode),
            saturday.hashCode),
        sunday.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CalendarSettings')
          ..add('monday', monday)
          ..add('tuesday', tuesday)
          ..add('wednesday', wednesday)
          ..add('thursday', thursday)
          ..add('friday', friday)
          ..add('saturday', saturday)
          ..add('sunday', sunday))
        .toString();
  }
}

class CalendarSettingsBuilder
    implements Builder<CalendarSettings, CalendarSettingsBuilder> {
  _$CalendarSettings? _$v;

  CalendarDaySettingsBuilder? _monday;
  CalendarDaySettingsBuilder get monday =>
      _$this._monday ??= new CalendarDaySettingsBuilder();
  set monday(CalendarDaySettingsBuilder? monday) => _$this._monday = monday;

  CalendarDaySettingsBuilder? _tuesday;
  CalendarDaySettingsBuilder get tuesday =>
      _$this._tuesday ??= new CalendarDaySettingsBuilder();
  set tuesday(CalendarDaySettingsBuilder? tuesday) => _$this._tuesday = tuesday;

  CalendarDaySettingsBuilder? _wednesday;
  CalendarDaySettingsBuilder get wednesday =>
      _$this._wednesday ??= new CalendarDaySettingsBuilder();
  set wednesday(CalendarDaySettingsBuilder? wednesday) =>
      _$this._wednesday = wednesday;

  CalendarDaySettingsBuilder? _thursday;
  CalendarDaySettingsBuilder get thursday =>
      _$this._thursday ??= new CalendarDaySettingsBuilder();
  set thursday(CalendarDaySettingsBuilder? thursday) =>
      _$this._thursday = thursday;

  CalendarDaySettingsBuilder? _friday;
  CalendarDaySettingsBuilder get friday =>
      _$this._friday ??= new CalendarDaySettingsBuilder();
  set friday(CalendarDaySettingsBuilder? friday) => _$this._friday = friday;

  CalendarDaySettingsBuilder? _saturday;
  CalendarDaySettingsBuilder get saturday =>
      _$this._saturday ??= new CalendarDaySettingsBuilder();
  set saturday(CalendarDaySettingsBuilder? saturday) =>
      _$this._saturday = saturday;

  CalendarDaySettingsBuilder? _sunday;
  CalendarDaySettingsBuilder get sunday =>
      _$this._sunday ??= new CalendarDaySettingsBuilder();
  set sunday(CalendarDaySettingsBuilder? sunday) => _$this._sunday = sunday;

  CalendarSettingsBuilder() {
    CalendarSettings._defaults(this);
  }

  CalendarSettingsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _monday = $v.monday?.toBuilder();
      _tuesday = $v.tuesday?.toBuilder();
      _wednesday = $v.wednesday?.toBuilder();
      _thursday = $v.thursday?.toBuilder();
      _friday = $v.friday?.toBuilder();
      _saturday = $v.saturday?.toBuilder();
      _sunday = $v.sunday?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CalendarSettings other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CalendarSettings;
  }

  @override
  void update(void Function(CalendarSettingsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CalendarSettings build() {
    _$CalendarSettings _$result;
    try {
      _$result = _$v ??
          new _$CalendarSettings._(
              monday: _monday?.build(),
              tuesday: _tuesday?.build(),
              wednesday: _wednesday?.build(),
              thursday: _thursday?.build(),
              friday: _friday?.build(),
              saturday: _saturday?.build(),
              sunday: _sunday?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'monday';
        _monday?.build();
        _$failedField = 'tuesday';
        _tuesday?.build();
        _$failedField = 'wednesday';
        _wednesday?.build();
        _$failedField = 'thursday';
        _thursday?.build();
        _$failedField = 'friday';
        _friday?.build();
        _$failedField = 'saturday';
        _saturday?.build();
        _$failedField = 'sunday';
        _sunday?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CalendarSettings', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
