// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Dashboard extends Dashboard {
  @override
  final BuiltList<DashboardUser> users;
  @override
  final BuiltList<DashboardEvent> events;

  factory _$Dashboard([void Function(DashboardBuilder)? updates]) =>
      (new DashboardBuilder()..update(updates))._build();

  _$Dashboard._({required this.users, required this.events}) : super._() {
    BuiltValueNullFieldError.checkNotNull(users, r'Dashboard', 'users');
    BuiltValueNullFieldError.checkNotNull(events, r'Dashboard', 'events');
  }

  @override
  Dashboard rebuild(void Function(DashboardBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardBuilder toBuilder() => new DashboardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Dashboard && users == other.users && events == other.events;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, users.hashCode), events.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Dashboard')
          ..add('users', users)
          ..add('events', events))
        .toString();
  }
}

class DashboardBuilder implements Builder<Dashboard, DashboardBuilder> {
  _$Dashboard? _$v;

  ListBuilder<DashboardUser>? _users;
  ListBuilder<DashboardUser> get users =>
      _$this._users ??= new ListBuilder<DashboardUser>();
  set users(ListBuilder<DashboardUser>? users) => _$this._users = users;

  ListBuilder<DashboardEvent>? _events;
  ListBuilder<DashboardEvent> get events =>
      _$this._events ??= new ListBuilder<DashboardEvent>();
  set events(ListBuilder<DashboardEvent>? events) => _$this._events = events;

  DashboardBuilder() {
    Dashboard._defaults(this);
  }

  DashboardBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _users = $v.users.toBuilder();
      _events = $v.events.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Dashboard other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Dashboard;
  }

  @override
  void update(void Function(DashboardBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Dashboard build() => _build();

  _$Dashboard _build() {
    _$Dashboard _$result;
    try {
      _$result = _$v ??
          new _$Dashboard._(users: users.build(), events: events.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'users';
        users.build();
        _$failedField = 'events';
        events.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Dashboard', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
