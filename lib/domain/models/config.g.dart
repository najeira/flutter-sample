// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return Config(
    json['darkTheme'] as bool ?? false,
    json['androidPageTransition'] as bool ?? false,
  );
}

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'darkTheme': instance.darkTheme,
      'androidPageTransition': instance.androidPageTransition,
    };
