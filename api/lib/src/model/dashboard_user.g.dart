// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardUser extends DashboardUser {
  @override
  final UserTypeEnum type;
  @override
  final bool isActivated;
  @override
  final bool isVerified;
  @override
  final int total;

  factory _$DashboardUser([void Function(DashboardUserBuilder)? updates]) =>
      (new DashboardUserBuilder()..update(updates))._build();

  _$DashboardUser._(
      {required this.type,
      required this.isActivated,
      required this.isVerified,
      required this.total})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(type, r'DashboardUser', 'type');
    BuiltValueNullFieldError.checkNotNull(
        isActivated, r'DashboardUser', 'isActivated');
    BuiltValueNullFieldError.checkNotNull(
        isVerified, r'DashboardUser', 'isVerified');
    BuiltValueNullFieldError.checkNotNull(total, r'DashboardUser', 'total');
  }

  @override
  DashboardUser rebuild(void Function(DashboardUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardUserBuilder toBuilder() => new DashboardUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardUser &&
        type == other.type &&
        isActivated == other.isActivated &&
        isVerified == other.isVerified &&
        total == other.total;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, type.hashCode), isActivated.hashCode),
            isVerified.hashCode),
        total.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardUser')
          ..add('type', type)
          ..add('isActivated', isActivated)
          ..add('isVerified', isVerified)
          ..add('total', total))
        .toString();
  }
}

class DashboardUserBuilder
    implements Builder<DashboardUser, DashboardUserBuilder> {
  _$DashboardUser? _$v;

  UserTypeEnum? _type;
  UserTypeEnum? get type => _$this._type;
  set type(UserTypeEnum? type) => _$this._type = type;

  bool? _isActivated;
  bool? get isActivated => _$this._isActivated;
  set isActivated(bool? isActivated) => _$this._isActivated = isActivated;

  bool? _isVerified;
  bool? get isVerified => _$this._isVerified;
  set isVerified(bool? isVerified) => _$this._isVerified = isVerified;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  DashboardUserBuilder() {
    DashboardUser._defaults(this);
  }

  DashboardUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _isActivated = $v.isActivated;
      _isVerified = $v.isVerified;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DashboardUser;
  }

  @override
  void update(void Function(DashboardUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardUser build() => _build();

  _$DashboardUser _build() {
    final _$result = _$v ??
        new _$DashboardUser._(
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'DashboardUser', 'type'),
            isActivated: BuiltValueNullFieldError.checkNotNull(
                isActivated, r'DashboardUser', 'isActivated'),
            isVerified: BuiltValueNullFieldError.checkNotNull(
                isVerified, r'DashboardUser', 'isVerified'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'DashboardUser', 'total'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
