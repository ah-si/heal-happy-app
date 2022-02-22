// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_room.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OfficeRoom extends OfficeRoom {
  @override
  final String id;
  @override
  final String officeId;
  @override
  final String name;

  factory _$OfficeRoom([void Function(OfficeRoomBuilder)? updates]) => (new OfficeRoomBuilder()..update(updates)).build();

  _$OfficeRoom._({required this.id, required this.officeId, required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'OfficeRoom', 'id');
    BuiltValueNullFieldError.checkNotNull(officeId, 'OfficeRoom', 'officeId');
    BuiltValueNullFieldError.checkNotNull(name, 'OfficeRoom', 'name');
  }

  @override
  OfficeRoom rebuild(void Function(OfficeRoomBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  OfficeRoomBuilder toBuilder() => new OfficeRoomBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OfficeRoom && id == other.id && officeId == other.officeId && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, id.hashCode), officeId.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OfficeRoom')
          ..add('id', id)
          ..add('officeId', officeId)
          ..add('name', name))
        .toString();
  }
}

class OfficeRoomBuilder implements Builder<OfficeRoom, OfficeRoomBuilder> {
  _$OfficeRoom? _$v;

  String? _id;

  String? get id => _$this._id;

  set id(String? id) => _$this._id = id;

  String? _officeId;

  String? get officeId => _$this._officeId;

  set officeId(String? officeId) => _$this._officeId = officeId;

  String? _name;

  String? get name => _$this._name;

  set name(String? name) => _$this._name = name;

  OfficeRoomBuilder() {
    OfficeRoom._defaults(this);
  }

  OfficeRoomBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _officeId = $v.officeId;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OfficeRoom other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OfficeRoom;
  }

  @override
  void update(void Function(OfficeRoomBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OfficeRoom build() {
    final _$result = _$v ??
        new _$OfficeRoom._(
            id: BuiltValueNullFieldError.checkNotNull(id, 'OfficeRoom', 'id'),
            officeId: BuiltValueNullFieldError.checkNotNull(officeId, 'OfficeRoom', 'officeId'),
            name: BuiltValueNullFieldError.checkNotNull(name, 'OfficeRoom', 'name'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
