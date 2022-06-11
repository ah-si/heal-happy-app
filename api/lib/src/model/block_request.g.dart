// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BlockRequest extends BlockRequest {
  @override
  final bool isBlocked;

  factory _$BlockRequest([void Function(BlockRequestBuilder)? updates]) =>
      (new BlockRequestBuilder()..update(updates)).build();

  _$BlockRequest._({required this.isBlocked}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isBlocked, 'BlockRequest', 'isBlocked');
  }

  @override
  BlockRequest rebuild(void Function(BlockRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BlockRequestBuilder toBuilder() => new BlockRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BlockRequest && isBlocked == other.isBlocked;
  }

  @override
  int get hashCode {
    return $jf($jc(0, isBlocked.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BlockRequest')
          ..add('isBlocked', isBlocked))
        .toString();
  }
}

class BlockRequestBuilder
    implements Builder<BlockRequest, BlockRequestBuilder> {
  _$BlockRequest? _$v;

  bool? _isBlocked;
  bool? get isBlocked => _$this._isBlocked;
  set isBlocked(bool? isBlocked) => _$this._isBlocked = isBlocked;

  BlockRequestBuilder() {
    BlockRequest._defaults(this);
  }

  BlockRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isBlocked = $v.isBlocked;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BlockRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BlockRequest;
  }

  @override
  void update(void Function(BlockRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BlockRequest build() {
    final _$result = _$v ??
        new _$BlockRequest._(
            isBlocked: BuiltValueNullFieldError.checkNotNull(
                isBlocked, 'BlockRequest', 'isBlocked'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
