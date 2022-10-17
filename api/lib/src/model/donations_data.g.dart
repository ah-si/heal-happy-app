// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donations_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DonationsData extends DonationsData {
  @override
  final DonationsMonthData current;
  @override
  final DonationsMonthData previous;

  factory _$DonationsData([void Function(DonationsDataBuilder)? updates]) =>
      (new DonationsDataBuilder()..update(updates))._build();

  _$DonationsData._({required this.current, required this.previous})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(current, r'DonationsData', 'current');
    BuiltValueNullFieldError.checkNotNull(
        previous, r'DonationsData', 'previous');
  }

  @override
  DonationsData rebuild(void Function(DonationsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DonationsDataBuilder toBuilder() => new DonationsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DonationsData &&
        current == other.current &&
        previous == other.previous;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, current.hashCode), previous.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DonationsData')
          ..add('current', current)
          ..add('previous', previous))
        .toString();
  }
}

class DonationsDataBuilder
    implements Builder<DonationsData, DonationsDataBuilder> {
  _$DonationsData? _$v;

  DonationsMonthDataBuilder? _current;
  DonationsMonthDataBuilder get current =>
      _$this._current ??= new DonationsMonthDataBuilder();
  set current(DonationsMonthDataBuilder? current) => _$this._current = current;

  DonationsMonthDataBuilder? _previous;
  DonationsMonthDataBuilder get previous =>
      _$this._previous ??= new DonationsMonthDataBuilder();
  set previous(DonationsMonthDataBuilder? previous) =>
      _$this._previous = previous;

  DonationsDataBuilder() {
    DonationsData._defaults(this);
  }

  DonationsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _current = $v.current.toBuilder();
      _previous = $v.previous.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DonationsData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DonationsData;
  }

  @override
  void update(void Function(DonationsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DonationsData build() => _build();

  _$DonationsData _build() {
    _$DonationsData _$result;
    try {
      _$result = _$v ??
          new _$DonationsData._(
              current: current.build(), previous: previous.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'current';
        current.build();
        _$failedField = 'previous';
        previous.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DonationsData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
