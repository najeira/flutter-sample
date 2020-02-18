abstract class ConfigState {
  const ConfigState();
}

class ConfigInitial extends ConfigState {
  const ConfigInitial();
}

class ConfigLoading extends ConfigState {
  const ConfigLoading();
}

class ConfigSuccess extends ConfigState {
  const ConfigSuccess();
}
