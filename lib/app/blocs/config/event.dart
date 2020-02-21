import 'package:flutter/material.dart';

abstract class ConfigEvent extends Notification {
  const ConfigEvent();
}

class ConfigStart extends ConfigEvent {
  const ConfigStart();
}

class ConfigThemeChange extends ConfigEvent {
  const ConfigThemeChange();
}

class ConfigPageTransitonChange extends ConfigEvent {
  const ConfigPageTransitonChange();
}
