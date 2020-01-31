import '../_imports.dart';

abstract class AppConfigEvent {
  const AppConfigEvent();
}

class AppConfigStart extends AppConfigEvent {
  const AppConfigStart();
}

class AppConfigLightThemeSet extends AppConfigEvent {
  const AppConfigLightThemeSet();
}

class AppConfigDarkThemeSet extends AppConfigEvent {
  const AppConfigDarkThemeSet();
}

class AppConfigUpdate extends AppConfigEvent {
  const AppConfigUpdate(this.data);

  final AppConfig data;
}
