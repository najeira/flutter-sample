import 'package:json_annotation/json_annotation.dart';

part 'app_config.g.dart';

@JsonSerializable()
class AppConfig {
  const AppConfig(
    this.darkTheme,
  ) : assert(darkTheme != null);

  const AppConfig.inital() : this(
    false,
  );

  factory AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);

  @JsonKey(defaultValue: false)
  final bool darkTheme;

  Map<String, dynamic> toJson() => _$AppConfigToJson(this);

  AppConfig copyWith({
    bool darkTheme,
  }) {
    return AppConfig(
      darkTheme ?? this.darkTheme,
    );
  }
}
