// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donations_month_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DonationsMonthData extends DonationsMonthData {
  @override
  final int total;
  @override
  final String currency;
  @override
  final BuiltMap<String, int> donations;

  factory _$DonationsMonthData(
          [void Function(DonationsMonthDataBuilder)? updates]) =>
      (new DonationsMonthDataBuilder()..update(updates))._build();

  _$DonationsMonthData._(
      {required this.total, required this.currency, required this.donations})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        total, r'DonationsMonthData', 'total');
    BuiltValueNullFieldError.checkNotNull(
        currency, r'DonationsMonthData', 'currency');
    BuiltValueNullFieldError.checkNotNull(
        donations, r'DonationsMonthData', 'donations');
  }

  @override
  DonationsMonthData rebuild(
          void Function(DonationsMonthDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DonationsMonthDataBuilder toBuilder() =>
      new DonationsMonthDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DonationsMonthData &&
        total == other.total &&
        currency == other.currency &&
        donations == other.donations;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, total.hashCode), currency.hashCode), donations.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DonationsMonthData')
          ..add('total', total)
          ..add('currency', currency)
          ..add('donations', donations))
        .toString();
  }
}

class DonationsMonthDataBuilder
    implements Builder<DonationsMonthData, DonationsMonthDataBuilder> {
  _$DonationsMonthData? _$v;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  MapBuilder<String, int>? _donations;
  MapBuilder<String, int> get donations =>
      _$this._donations ??= new MapBuilder<String, int>();
  set donations(MapBuilder<String, int>? donations) =>
      _$this._donations = donations;

  DonationsMonthDataBuilder() {
    DonationsMonthData._defaults(this);
  }

  DonationsMonthDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total = $v.total;
      _currency = $v.currency;
      _donations = $v.donations.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DonationsMonthData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DonationsMonthData;
  }

  @override
  void update(void Function(DonationsMonthDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DonationsMonthData build() => _build();

  _$DonationsMonthData _build() {
    _$DonationsMonthData _$result;
    try {
      _$result = _$v ??
          new _$DonationsMonthData._(
              total: BuiltValueNullFieldError.checkNotNull(
                  total, r'DonationsMonthData', 'total'),
              currency: BuiltValueNullFieldError.checkNotNull(
                  currency, r'DonationsMonthData', 'currency'),
              donations: donations.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'donations';
        donations.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DonationsMonthData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
