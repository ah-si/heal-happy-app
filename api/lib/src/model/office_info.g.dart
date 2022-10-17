// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OfficeInfo extends OfficeInfo {
  @override
  final String? id;
  @override
  final String name;
  @override
  final String street;
  @override
  final String street2;
  @override
  final String city;
  @override
  final String zipCode;

  factory _$OfficeInfo([void Function(OfficeInfoBuilder)? updates]) =>
      (new OfficeInfoBuilder()..update(updates))._build();

  _$OfficeInfo._(
      {this.id,
      required this.name,
      required this.street,
      required this.street2,
      required this.city,
      required this.zipCode})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'OfficeInfo', 'name');
    BuiltValueNullFieldError.checkNotNull(street, r'OfficeInfo', 'street');
    BuiltValueNullFieldError.checkNotNull(street2, r'OfficeInfo', 'street2');
    BuiltValueNullFieldError.checkNotNull(city, r'OfficeInfo', 'city');
    BuiltValueNullFieldError.checkNotNull(zipCode, r'OfficeInfo', 'zipCode');
  }

  @override
  OfficeInfo rebuild(void Function(OfficeInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OfficeInfoBuilder toBuilder() => new OfficeInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OfficeInfo &&
        id == other.id &&
        name == other.name &&
        street == other.street &&
        street2 == other.street2 &&
        city == other.city &&
        zipCode == other.zipCode;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, id.hashCode), name.hashCode), street.hashCode),
                street2.hashCode),
            city.hashCode),
        zipCode.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OfficeInfo')
          ..add('id', id)
          ..add('name', name)
          ..add('street', street)
          ..add('street2', street2)
          ..add('city', city)
          ..add('zipCode', zipCode))
        .toString();
  }
}

class OfficeInfoBuilder implements Builder<OfficeInfo, OfficeInfoBuilder> {
  _$OfficeInfo? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _street;
  String? get street => _$this._street;
  set street(String? street) => _$this._street = street;

  String? _street2;
  String? get street2 => _$this._street2;
  set street2(String? street2) => _$this._street2 = street2;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _zipCode;
  String? get zipCode => _$this._zipCode;
  set zipCode(String? zipCode) => _$this._zipCode = zipCode;

  OfficeInfoBuilder() {
    OfficeInfo._defaults(this);
  }

  OfficeInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _street = $v.street;
      _street2 = $v.street2;
      _city = $v.city;
      _zipCode = $v.zipCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OfficeInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OfficeInfo;
  }

  @override
  void update(void Function(OfficeInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OfficeInfo build() => _build();

  _$OfficeInfo _build() {
    final _$result = _$v ??
        new _$OfficeInfo._(
            id: id,
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'OfficeInfo', 'name'),
            street: BuiltValueNullFieldError.checkNotNull(
                street, r'OfficeInfo', 'street'),
            street2: BuiltValueNullFieldError.checkNotNull(
                street2, r'OfficeInfo', 'street2'),
            city: BuiltValueNullFieldError.checkNotNull(
                city, r'OfficeInfo', 'city'),
            zipCode: BuiltValueNullFieldError.checkNotNull(
                zipCode, r'OfficeInfo', 'zipCode'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
