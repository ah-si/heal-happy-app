// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FileData extends FileData {
  @override
  final String path;

  factory _$FileData([void Function(FileDataBuilder)? updates]) =>
      (new FileDataBuilder()..update(updates)).build();

  _$FileData._({required this.path}) : super._() {
    BuiltValueNullFieldError.checkNotNull(path, 'FileData', 'path');
  }

  @override
  FileData rebuild(void Function(FileDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FileDataBuilder toBuilder() => new FileDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FileData && path == other.path;
  }

  @override
  int get hashCode {
    return $jf($jc(0, path.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FileData')..add('path', path))
        .toString();
  }
}

class FileDataBuilder implements Builder<FileData, FileDataBuilder> {
  _$FileData? _$v;

  String? _path;
  String? get path => _$this._path;
  set path(String? path) => _$this._path = path;

  FileDataBuilder() {
    FileData._defaults(this);
  }

  FileDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _path = $v.path;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FileData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FileData;
  }

  @override
  void update(void Function(FileDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FileData build() {
    final _$result = _$v ??
        new _$FileData._(
            path: BuiltValueNullFieldError.checkNotNull(
                path, 'FileData', 'path'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
