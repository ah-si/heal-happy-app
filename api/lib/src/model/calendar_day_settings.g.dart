// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_day_settings.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CalendarDaySettings extends CalendarDaySettings {
  @override
  final int? startHour;
  @override
  final int? startMinute;
  @override
  final int? endHour;
  @override
  final int? endMinute;
  @override
  final int? start2Hour;
  @override
  final int? start2Minute;
  @override
  final int? end2Hour;
  @override
  final int? end2Minute;

  factory _$CalendarDaySettings(
          [void Function(CalendarDaySettingsBuilder)? updates]) =>
      (new CalendarDaySettingsBuilder()..update(updates)).build();

  _$CalendarDaySettings._(
      {this.startHour,
      this.startMinute,
      this.endHour,
      this.endMinute,
      this.start2Hour,
      this.start2Minute,
      this.end2Hour,
      this.end2Minute})
      : super._();

  @override
  CalendarDaySettings rebuild(
          void Function(CalendarDaySettingsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CalendarDaySettingsBuilder toBuilder() =>
      new CalendarDaySettingsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CalendarDaySettings &&
        startHour == other.startHour &&
        startMinute == other.startMinute &&
        endHour == other.endHour &&
        endMinute == other.endMinute &&
        start2Hour == other.start2Hour &&
        start2Minute == other.start2Minute &&
        end2Hour == other.end2Hour &&
        end2Minute == other.end2Minute;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc(0, startHour.hashCode),
                                startMinute.hashCode),
                            endHour.hashCode),
                        endMinute.hashCode),
                    start2Hour.hashCode),
                start2Minute.hashCode),
            end2Hour.hashCode),
        end2Minute.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CalendarDaySettings')
          ..add('startHour', startHour)
          ..add('startMinute', startMinute)
          ..add('endHour', endHour)
          ..add('endMinute', endMinute)
          ..add('start2Hour', start2Hour)
          ..add('start2Minute', start2Minute)
          ..add('end2Hour', end2Hour)
          ..add('end2Minute', end2Minute))
        .toString();
  }
}

class CalendarDaySettingsBuilder
    implements Builder<CalendarDaySettings, CalendarDaySettingsBuilder> {
  _$CalendarDaySettings? _$v;

  int? _startHour;
  int? get startHour => _$this._startHour;
  set startHour(int? startHour) => _$this._startHour = startHour;

  int? _startMinute;
  int? get startMinute => _$this._startMinute;
  set startMinute(int? startMinute) => _$this._startMinute = startMinute;

  int? _endHour;
  int? get endHour => _$this._endHour;
  set endHour(int? endHour) => _$this._endHour = endHour;

  int? _endMinute;
  int? get endMinute => _$this._endMinute;
  set endMinute(int? endMinute) => _$this._endMinute = endMinute;

  int? _start2Hour;
  int? get start2Hour => _$this._start2Hour;
  set start2Hour(int? start2Hour) => _$this._start2Hour = start2Hour;

  int? _start2Minute;
  int? get start2Minute => _$this._start2Minute;
  set start2Minute(int? start2Minute) => _$this._start2Minute = start2Minute;

  int? _end2Hour;
  int? get end2Hour => _$this._end2Hour;
  set end2Hour(int? end2Hour) => _$this._end2Hour = end2Hour;

  int? _end2Minute;
  int? get end2Minute => _$this._end2Minute;
  set end2Minute(int? end2Minute) => _$this._end2Minute = end2Minute;

  CalendarDaySettingsBuilder() {
    CalendarDaySettings._defaults(this);
  }

  CalendarDaySettingsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _startHour = $v.startHour;
      _startMinute = $v.startMinute;
      _endHour = $v.endHour;
      _endMinute = $v.endMinute;
      _start2Hour = $v.start2Hour;
      _start2Minute = $v.start2Minute;
      _end2Hour = $v.end2Hour;
      _end2Minute = $v.end2Minute;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CalendarDaySettings other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CalendarDaySettings;
  }

  @override
  void update(void Function(CalendarDaySettingsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CalendarDaySettings build() {
    final _$result = _$v ??
        new _$CalendarDaySettings._(
            startHour: startHour,
            startMinute: startMinute,
            endHour: endHour,
            endMinute: endMinute,
            start2Hour: start2Hour,
            start2Minute: start2Minute,
            end2Hour: end2Hour,
            end2Minute: end2Minute);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
