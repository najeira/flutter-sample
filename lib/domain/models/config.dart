import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  const Config(
    this.darkTheme,
  ) : assert(darkTheme != null);

  const Config.inital() : this(
    false,
  );

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  @JsonKey(defaultValue: false)
  final bool darkTheme;

  Map<String, dynamic> toJson() => _$ConfigToJson(this);

  Config copyWith({
    bool darkTheme,
  }) {
    return Config(
      darkTheme ?? this.darkTheme,
    );
  }
}
