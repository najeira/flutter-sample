import 'package:state_notifier/state_notifier.dart';

import 'package:flutter_sample/domain/domain.dart';

class ConfigNotifier extends StateNotifier<Config> {
  ConfigNotifier(Config state) : super(state);

  Config get config => state;

  set config(Config value) {
    state = value;
  }

  void setDarkTheme(bool value) {
    state = config.copyWith(darkTheme: value);
  }

  void setAndroidPageTransition(bool value) {
    state = config.copyWith(androidPageTransition: value);
  }
}
