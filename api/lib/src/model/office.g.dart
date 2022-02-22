// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Office extends Office {
  @override
  final String id;
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
  @override
  final BuiltList<OfficeRoom> rooms;

  factory _$Office([void Function(OfficeBuilder)? updates]) => (new OfficeBuilder()..update(updates)).build();

  _$Office._(
      {required this.id, required this.name, required this.street, required this.street2, required this.city, required this.zipCode, required this.rooms})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'Office', 'id');
    BuiltValueNullFieldError.checkNotNull(name, 'Office', 'name');
    BuiltValueNullFieldError.checkNotNull(street, 'Office', 'street');
    BuiltValueNullFieldError.checkNotNull(street2, 'Office', 'street2');
    BuiltValueNullFieldError.checkNotNull(city, 'Office', 'city');
    BuiltValueNullFieldError.checkNotNull(zipCode, 'Office', 'zipCode');
    BuiltValueNullFieldError.checkNotNull(rooms, 'Office', 'rooms');
  }

  @override
  Office rebuild(void Function(OfficeBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  OfficeBuilder toBuilder() => new OfficeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Office &&
        id == other.id &&
        name == other.name &&
        street == other.street &&
        street2 == other.street2 &&
        city == other.city &&
        zipCode == other.zipCode &&
        rooms == other.rooms;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc($jc($jc($jc($jc(0, id.hashCode), name.hashCode), street.hashCode), street2.hashCode), city.hashCode), zipCode.hashCode), rooms.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Office')
          ..add('id', id)
          ..add('name', name)
          ..add('street', street)
          ..add('street2', street2)
          ..add('city', city)
          ..add('zipCode', zipCode)
          ..add('rooms', rooms))
        .toString();
  }
}

class OfficeBuilder implements Builder<Office, OfficeBuilder> {
  _$Office? _$v;

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

  ListBuilder<OfficeRoom>? _rooms;

  ListBuilder<OfficeRoom> get rooms => _$this._rooms ??= new ListBuilder<OfficeRoom>();

  set rooms(ListBuilder<OfficeRoom>? rooms) => _$this._rooms = rooms;

  OfficeBuilder() {
    Office._defaults(this);
  }

  OfficeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _street = $v.street;
      _street2 = $v.street2;
      _city = $v.city;
      _zipCode = $v.zipCode;
      _rooms = $v.rooms.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Office other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Office;
  }

  @override
  void update(void Function(OfficeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Office build() {
    _$Office _$result;
    try {
      _$result = _$v ??
          new _$Office._(
              id: BuiltValueNullFieldError.checkNotNull(id, 'Office', 'id'),
              name: BuiltValueNullFieldError.checkNotNull(name, 'Office', 'name'),
              street: BuiltValueNullFieldError.checkNotNull(street, 'Office', 'street'),
              street2: BuiltValueNullFieldError.checkNotNull(street2, 'Office', 'street2'),
              city: BuiltValueNullFieldError.checkNotNull(city, 'Office', 'city'),
              zipCode: BuiltValueNullFieldError.checkNotNull(zipCode, 'Office', 'zipCode'),
              rooms: rooms.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'rooms';
        rooms.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError('Office', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
