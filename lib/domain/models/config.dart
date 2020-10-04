import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@freezed
abstract class Config with _$Config {
  const factory Config({
    @Default(false) bool darkTheme,
    @Default(false) bool androidPageTransition,
  }) = _Config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
