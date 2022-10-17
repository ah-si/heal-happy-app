// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Slot extends Slot {
  @override
  final String? roomId;
  @override
  final BuiltList<DateTime> slots;

  factory _$Slot([void Function(SlotBuilder)? updates]) =>
      (new SlotBuilder()..update(updates))._build();

  _$Slot._({this.roomId, required this.slots}) : super._() {
    BuiltValueNullFieldError.checkNotNull(slots, r'Slot', 'slots');
  }

  @override
  Slot rebuild(void Function(SlotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SlotBuilder toBuilder() => new SlotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Slot && roomId == other.roomId && slots == other.slots;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, roomId.hashCode), slots.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Slot')
          ..add('roomId', roomId)
          ..add('slots', slots))
        .toString();
  }
}

class SlotBuilder implements Builder<Slot, SlotBuilder> {
  _$Slot? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  ListBuilder<DateTime>? _slots;
  ListBuilder<DateTime> get slots =>
      _$this._slots ??= new ListBuilder<DateTime>();
  set slots(ListBuilder<DateTime>? slots) => _$this._slots = slots;

  SlotBuilder() {
    Slot._defaults(this);
  }

  SlotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _slots = $v.slots.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Slot other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Slot;
  }

  @override
  void update(void Function(SlotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Slot build() => _build();

  _$Slot _build() {
    _$Slot _$result;
    try {
      _$result = _$v ?? new _$Slot._(roomId: roomId, slots: slots.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'slots';
        slots.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Slot', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
