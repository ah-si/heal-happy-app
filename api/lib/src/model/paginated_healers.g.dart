// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_healers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaginatedHealers extends PaginatedHealers {
  @override
  final int totalPages;
  @override
  final BuiltList<Healer> healers;

  factory _$PaginatedHealers(
          [void Function(PaginatedHealersBuilder)? updates]) =>
      (new PaginatedHealersBuilder()..update(updates))._build();

  _$PaginatedHealers._({required this.totalPages, required this.healers})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        totalPages, r'PaginatedHealers', 'totalPages');
    BuiltValueNullFieldError.checkNotNull(
        healers, r'PaginatedHealers', 'healers');
  }

  @override
  PaginatedHealers rebuild(void Function(PaginatedHealersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaginatedHealersBuilder toBuilder() =>
      new PaginatedHealersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaginatedHealers &&
        totalPages == other.totalPages &&
        healers == other.healers;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, totalPages.hashCode), healers.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaginatedHealers')
          ..add('totalPages', totalPages)
          ..add('healers', healers))
        .toString();
  }
}

class PaginatedHealersBuilder
    implements Builder<PaginatedHealers, PaginatedHealersBuilder> {
  _$PaginatedHealers? _$v;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  ListBuilder<Healer>? _healers;
  ListBuilder<Healer> get healers =>
      _$this._healers ??= new ListBuilder<Healer>();
  set healers(ListBuilder<Healer>? healers) => _$this._healers = healers;

  PaginatedHealersBuilder() {
    PaginatedHealers._defaults(this);
  }

  PaginatedHealersBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalPages = $v.totalPages;
      _healers = $v.healers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaginatedHealers other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaginatedHealers;
  }

  @override
  void update(void Function(PaginatedHealersBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaginatedHealers build() => _build();

  _$PaginatedHealers _build() {
    _$PaginatedHealers _$result;
    try {
      _$result = _$v ??
          new _$PaginatedHealers._(
              totalPages: BuiltValueNullFieldError.checkNotNull(
                  totalPages, r'PaginatedHealers', 'totalPages'),
              healers: healers.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'healers';
        healers.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PaginatedHealers', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
