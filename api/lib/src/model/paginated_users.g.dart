// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_users.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaginatedUsers extends PaginatedUsers {
  @override
  final int totalPages;
  @override
  final BuiltList<User> users;

  factory _$PaginatedUsers([void Function(PaginatedUsersBuilder)? updates]) =>
      (new PaginatedUsersBuilder()..update(updates))._build();

  _$PaginatedUsers._({required this.totalPages, required this.users})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        totalPages, r'PaginatedUsers', 'totalPages');
    BuiltValueNullFieldError.checkNotNull(users, r'PaginatedUsers', 'users');
  }

  @override
  PaginatedUsers rebuild(void Function(PaginatedUsersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaginatedUsersBuilder toBuilder() =>
      new PaginatedUsersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaginatedUsers &&
        totalPages == other.totalPages &&
        users == other.users;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, totalPages.hashCode), users.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaginatedUsers')
          ..add('totalPages', totalPages)
          ..add('users', users))
        .toString();
  }
}

class PaginatedUsersBuilder
    implements Builder<PaginatedUsers, PaginatedUsersBuilder> {
  _$PaginatedUsers? _$v;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  ListBuilder<User>? _users;
  ListBuilder<User> get users => _$this._users ??= new ListBuilder<User>();
  set users(ListBuilder<User>? users) => _$this._users = users;

  PaginatedUsersBuilder() {
    PaginatedUsers._defaults(this);
  }

  PaginatedUsersBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalPages = $v.totalPages;
      _users = $v.users.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaginatedUsers other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaginatedUsers;
  }

  @override
  void update(void Function(PaginatedUsersBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaginatedUsers build() => _build();

  _$PaginatedUsers _build() {
    _$PaginatedUsers _$result;
    try {
      _$result = _$v ??
          new _$PaginatedUsers._(
              totalPages: BuiltValueNullFieldError.checkNotNull(
                  totalPages, r'PaginatedUsers', 'totalPages'),
              users: users.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'users';
        users.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PaginatedUsers', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
