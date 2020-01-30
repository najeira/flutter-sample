// アプリの状態であり、ドメインモデルではないので
// domain以下ではなくここに定義しておく
class AppConfig {
  const AppConfig({
    this.darkTheme = false,
  }) : assert(darkTheme != null);

  final bool darkTheme;

  AppConfig copyWith({
    bool darkTheme,
  }) {
    return AppConfig(
      darkTheme: darkTheme ?? this.darkTheme,
    );
  }
}

abstract class AppConfigState {
  const AppConfigState(this.data);

  final AppConfig data;
}

class AppConfigInitial extends AppConfigState {
  const AppConfigInitial(AppConfig data) : super(data);
}

class AppConfigLoadSuccess extends AppConfigState {
  const AppConfigLoadSuccess(AppConfig data) : super(data);
}
