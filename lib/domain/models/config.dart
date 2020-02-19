import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  const Config(
    this.darkTheme,
    this.androidPageTransition,
  ) : assert(darkTheme != null);

  const Config.inital() : this(
    false,
    false,
  );

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  @JsonKey(defaultValue: false)
  final bool darkTheme;

  @JsonKey(defaultValue: false)
  final bool androidPageTransition;

  Map<String, dynamic> toJson() => _$ConfigToJson(this);

  Config copyWith({
    bool darkTheme,
    bool androidPageTransition,
  }) {
    return Config(
      darkTheme ?? this.darkTheme,
      androidPageTransition ?? this.androidPageTransition,
    );
  }
}
