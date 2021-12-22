// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_events.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaginatedEvents extends PaginatedEvents {
  @override
  final int totalPages;
  @override
  final BuiltList<AdminUserEvent> events;

  factory _$PaginatedEvents([void Function(PaginatedEventsBuilder)? updates]) =>
      (new PaginatedEventsBuilder()..update(updates)).build();

  _$PaginatedEvents._({required this.totalPages, required this.events})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        totalPages, 'PaginatedEvents', 'totalPages');
    BuiltValueNullFieldError.checkNotNull(events, 'PaginatedEvents', 'events');
  }

  @override
  PaginatedEvents rebuild(void Function(PaginatedEventsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaginatedEventsBuilder toBuilder() =>
      new PaginatedEventsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaginatedEvents &&
        totalPages == other.totalPages &&
        events == other.events;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, totalPages.hashCode), events.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaginatedEvents')
          ..add('totalPages', totalPages)
          ..add('events', events))
        .toString();
  }
}

class PaginatedEventsBuilder
    implements Builder<PaginatedEvents, PaginatedEventsBuilder> {
  _$PaginatedEvents? _$v;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  ListBuilder<AdminUserEvent>? _events;
  ListBuilder<AdminUserEvent> get events =>
      _$this._events ??= new ListBuilder<AdminUserEvent>();
  set events(ListBuilder<AdminUserEvent>? events) => _$this._events = events;

  PaginatedEventsBuilder() {
    PaginatedEvents._defaults(this);
  }

  PaginatedEventsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalPages = $v.totalPages;
      _events = $v.events.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaginatedEvents other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaginatedEvents;
  }

  @override
  void update(void Function(PaginatedEventsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaginatedEvents build() {
    _$PaginatedEvents _$result;
    try {
      _$result = _$v ??
          new _$PaginatedEvents._(
              totalPages: BuiltValueNullFieldError.checkNotNull(
                  totalPages, 'PaginatedEvents', 'totalPages'),
              events: events.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'events';
        events.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PaginatedEvents', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
