// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Config _$ConfigFromJson(Map<String, dynamic> json) {
  return _Config.fromJson(json);
}

class _$ConfigTearOff {
  const _$ConfigTearOff();

// ignore: unused_element
  _Config call({bool darkTheme = false, bool androidPageTransition = false}) {
    return _Config(
      darkTheme: darkTheme,
      androidPageTransition: androidPageTransition,
    );
  }
}

// ignore: unused_element
const $Config = _$ConfigTearOff();

mixin _$Config {
  bool get darkTheme;
  bool get androidPageTransition;

  Map<String, dynamic> toJson();
  $ConfigCopyWith<Config> get copyWith;
}

abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res>;
  $Res call({bool darkTheme, bool androidPageTransition});
}

class _$ConfigCopyWithImpl<$Res> implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  final Config _value;
  // ignore: unused_field
  final $Res Function(Config) _then;

  @override
  $Res call({
    Object darkTheme = freezed,
    Object androidPageTransition = freezed,
  }) {
    return _then(_value.copyWith(
      darkTheme: darkTheme == freezed ? _value.darkTheme : darkTheme as bool,
      androidPageTransition: androidPageTransition == freezed
          ? _value.androidPageTransition
          : androidPageTransition as bool,
    ));
  }
}

abstract class _$ConfigCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$ConfigCopyWith(_Config value, $Res Function(_Config) then) =
      __$ConfigCopyWithImpl<$Res>;
  @override
  $Res call({bool darkTheme, bool androidPageTransition});
}

class __$ConfigCopyWithImpl<$Res> extends _$ConfigCopyWithImpl<$Res>
    implements _$ConfigCopyWith<$Res> {
  __$ConfigCopyWithImpl(_Config _value, $Res Function(_Config) _then)
      : super(_value, (v) => _then(v as _Config));

  @override
  _Config get _value => super._value as _Config;

  @override
  $Res call({
    Object darkTheme = freezed,
    Object androidPageTransition = freezed,
  }) {
    return _then(_Config(
      darkTheme: darkTheme == freezed ? _value.darkTheme : darkTheme as bool,
      androidPageTransition: androidPageTransition == freezed
          ? _value.androidPageTransition
          : androidPageTransition as bool,
    ));
  }
}

@JsonSerializable()
class _$_Config with DiagnosticableTreeMixin implements _Config {
  const _$_Config({this.darkTheme = false, this.androidPageTransition = false})
      : assert(darkTheme != null),
        assert(androidPageTransition != null);

  factory _$_Config.fromJson(Map<String, dynamic> json) =>
      _$_$_ConfigFromJson(json);

  @JsonKey(defaultValue: false)
  @override
  final bool darkTheme;
  @JsonKey(defaultValue: false)
  @override
  final bool androidPageTransition;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Config(darkTheme: $darkTheme, androidPageTransition: $androidPageTransition)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Config'))
      ..add(DiagnosticsProperty('darkTheme', darkTheme))
      ..add(
          DiagnosticsProperty('androidPageTransition', androidPageTransition));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Config &&
            (identical(other.darkTheme, darkTheme) ||
                const DeepCollectionEquality()
                    .equals(other.darkTheme, darkTheme)) &&
            (identical(other.androidPageTransition, androidPageTransition) ||
                const DeepCollectionEquality().equals(
                    other.androidPageTransition, androidPageTransition)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(darkTheme) ^
      const DeepCollectionEquality().hash(androidPageTransition);

  @override
  _$ConfigCopyWith<_Config> get copyWith =>
      __$ConfigCopyWithImpl<_Config>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ConfigToJson(this);
  }
}

abstract class _Config implements Config {
  const factory _Config({bool darkTheme, bool androidPageTransition}) =
      _$_Config;

  factory _Config.fromJson(Map<String, dynamic> json) = _$_Config.fromJson;

  @override
  bool get darkTheme;
  @override
  bool get androidPageTransition;
  @override
  _$ConfigCopyWith<_Config> get copyWith;
}
