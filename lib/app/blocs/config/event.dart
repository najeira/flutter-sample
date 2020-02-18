import '../_imports.dart';

abstract class ConfigEvent extends AppEvent {
  const ConfigEvent();
}

class ConfigStart extends ConfigEvent {
  const ConfigStart();
}

class ConfigThemeChange extends ConfigEvent {
  const ConfigThemeChange();
}
