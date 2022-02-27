// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_offices.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaginatedOffices extends PaginatedOffices {
  @override
  final int totalPages;
  @override
  final BuiltList<Office> offices;

  factory _$PaginatedOffices(
          [void Function(PaginatedOfficesBuilder)? updates]) =>
      (new PaginatedOfficesBuilder()..update(updates)).build();

  _$PaginatedOffices._({required this.totalPages, required this.offices})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        totalPages, 'PaginatedOffices', 'totalPages');
    BuiltValueNullFieldError.checkNotNull(
        offices, 'PaginatedOffices', 'offices');
  }

  @override
  PaginatedOffices rebuild(void Function(PaginatedOfficesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaginatedOfficesBuilder toBuilder() =>
      new PaginatedOfficesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaginatedOffices &&
        totalPages == other.totalPages &&
        offices == other.offices;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, totalPages.hashCode), offices.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaginatedOffices')
          ..add('totalPages', totalPages)
          ..add('offices', offices))
        .toString();
  }
}

class PaginatedOfficesBuilder
    implements Builder<PaginatedOffices, PaginatedOfficesBuilder> {
  _$PaginatedOffices? _$v;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  ListBuilder<Office>? _offices;
  ListBuilder<Office> get offices =>
      _$this._offices ??= new ListBuilder<Office>();
  set offices(ListBuilder<Office>? offices) => _$this._offices = offices;

  PaginatedOfficesBuilder() {
    PaginatedOffices._defaults(this);
  }

  PaginatedOfficesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalPages = $v.totalPages;
      _offices = $v.offices.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaginatedOffices other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaginatedOffices;
  }

  @override
  void update(void Function(PaginatedOfficesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaginatedOffices build() {
    _$PaginatedOffices _$result;
    try {
      _$result = _$v ??
          new _$PaginatedOffices._(
              totalPages: BuiltValueNullFieldError.checkNotNull(
                  totalPages, 'PaginatedOffices', 'totalPages'),
              offices: offices.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'offices';
        offices.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PaginatedOffices', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
