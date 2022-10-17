// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'healer_availabilities.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HealerAvailabilities extends HealerAvailabilities {
  @override
  final BuiltList<Slot> slots;
  @override
  final String until;

  factory _$HealerAvailabilities(
          [void Function(HealerAvailabilitiesBuilder)? updates]) =>
      (new HealerAvailabilitiesBuilder()..update(updates))._build();

  _$HealerAvailabilities._({required this.slots, required this.until})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        slots, r'HealerAvailabilities', 'slots');
    BuiltValueNullFieldError.checkNotNull(
        until, r'HealerAvailabilities', 'until');
  }

  @override
  HealerAvailabilities rebuild(
          void Function(HealerAvailabilitiesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HealerAvailabilitiesBuilder toBuilder() =>
      new HealerAvailabilitiesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HealerAvailabilities &&
        slots == other.slots &&
        until == other.until;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, slots.hashCode), until.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HealerAvailabilities')
          ..add('slots', slots)
          ..add('until', until))
        .toString();
  }
}

class HealerAvailabilitiesBuilder
    implements Builder<HealerAvailabilities, HealerAvailabilitiesBuilder> {
  _$HealerAvailabilities? _$v;

  ListBuilder<Slot>? _slots;
  ListBuilder<Slot> get slots => _$this._slots ??= new ListBuilder<Slot>();
  set slots(ListBuilder<Slot>? slots) => _$this._slots = slots;

  String? _until;
  String? get until => _$this._until;
  set until(String? until) => _$this._until = until;

  HealerAvailabilitiesBuilder() {
    HealerAvailabilities._defaults(this);
  }

  HealerAvailabilitiesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _slots = $v.slots.toBuilder();
      _until = $v.until;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealerAvailabilities other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HealerAvailabilities;
  }

  @override
  void update(void Function(HealerAvailabilitiesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HealerAvailabilities build() => _build();

  _$HealerAvailabilities _build() {
    _$HealerAvailabilities _$result;
    try {
      _$result = _$v ??
          new _$HealerAvailabilities._(
              slots: slots.build(),
              until: BuiltValueNullFieldError.checkNotNull(
                  until, r'HealerAvailabilities', 'until'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'slots';
        slots.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'HealerAvailabilities', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
