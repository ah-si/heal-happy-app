// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppSettings extends AppSettings {
  @override
  final bool enableUrgencyButton;

  factory _$AppSettings([void Function(AppSettingsBuilder)? updates]) =>
      (new AppSettingsBuilder()..update(updates)).build();

  _$AppSettings._({required this.enableUrgencyButton}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        enableUrgencyButton, 'AppSettings', 'enableUrgencyButton');
  }

  @override
  AppSettings rebuild(void Function(AppSettingsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppSettingsBuilder toBuilder() => new AppSettingsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppSettings &&
        enableUrgencyButton == other.enableUrgencyButton;
  }

  @override
  int get hashCode {
    return $jf($jc(0, enableUrgencyButton.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppSettings')
          ..add('enableUrgencyButton', enableUrgencyButton))
        .toString();
  }
}

class AppSettingsBuilder implements Builder<AppSettings, AppSettingsBuilder> {
  _$AppSettings? _$v;

  bool? _enableUrgencyButton;
  bool? get enableUrgencyButton => _$this._enableUrgencyButton;
  set enableUrgencyButton(bool? enableUrgencyButton) =>
      _$this._enableUrgencyButton = enableUrgencyButton;

  AppSettingsBuilder() {
    AppSettings._defaults(this);
  }

  AppSettingsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enableUrgencyButton = $v.enableUrgencyButton;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppSettings other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppSettings;
  }

  @override
  void update(void Function(AppSettingsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppSettings build() {
    final _$result = _$v ??
        new _$AppSettings._(
            enableUrgencyButton: BuiltValueNullFieldError.checkNotNull(
                enableUrgencyButton, 'AppSettings', 'enableUrgencyButton'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
