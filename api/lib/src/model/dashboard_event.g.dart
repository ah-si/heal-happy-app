// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardEvent extends DashboardEvent {
  @override
  final int year;
  @override
  final int month;
  @override
  final int total;

  factory _$DashboardEvent([void Function(DashboardEventBuilder)? updates]) =>
      (new DashboardEventBuilder()..update(updates)).build();

  _$DashboardEvent._(
      {required this.year, required this.month, required this.total})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(year, 'DashboardEvent', 'year');
    BuiltValueNullFieldError.checkNotNull(month, 'DashboardEvent', 'month');
    BuiltValueNullFieldError.checkNotNull(total, 'DashboardEvent', 'total');
  }

  @override
  DashboardEvent rebuild(void Function(DashboardEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardEventBuilder toBuilder() =>
      new DashboardEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardEvent &&
        year == other.year &&
        month == other.month &&
        total == other.total;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, year.hashCode), month.hashCode), total.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashboardEvent')
          ..add('year', year)
          ..add('month', month)
          ..add('total', total))
        .toString();
  }
}

class DashboardEventBuilder
    implements Builder<DashboardEvent, DashboardEventBuilder> {
  _$DashboardEvent? _$v;

  int? _year;
  int? get year => _$this._year;
  set year(int? year) => _$this._year = year;

  int? _month;
  int? get month => _$this._month;
  set month(int? month) => _$this._month = month;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  DashboardEventBuilder() {
    DashboardEvent._defaults(this);
  }

  DashboardEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _year = $v.year;
      _month = $v.month;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardEvent other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DashboardEvent;
  }

  @override
  void update(void Function(DashboardEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DashboardEvent build() {
    final _$result = _$v ??
        new _$DashboardEvent._(
            year: BuiltValueNullFieldError.checkNotNull(
                year, 'DashboardEvent', 'year'),
            month: BuiltValueNullFieldError.checkNotNull(
                month, 'DashboardEvent', 'month'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, 'DashboardEvent', 'total'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
