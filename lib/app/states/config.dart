import 'package:state_notifier/state_notifier.dart';

import 'package:flutter_sample/domain/domain.dart';

class ConfigController extends StateNotifier<Config> {
  ConfigController(Config state) : super(state);

  Config get config => state;

  void setDarkTheme(bool value) {
    state = config.copyWith(darkTheme: value);
  }

  void setAndroidPageTransition(bool value) {
    state = config.copyWith(androidPageTransition: value);
  }
}
