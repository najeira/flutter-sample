import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_sample/domain/models/config.dart';

class ConfigRepository {
  ConfigRepository();

  static const String _key = "config";

  Box<String> _hiveBox;

  Future<Config> load() async {
    final Box<String> box = await _box();
    final String data = box.get(_key);
    if (data == null || data.isEmpty) {
      return const Config(
        darkTheme: false,
        androidPageTransition: false,
      );
    }
    return Config.fromJson(json.decode(data) as Map<String, dynamic>);
  }

  Future<void> save(Config config) async {
    final String data = json.encode(config);
    final Box<String> box = await _box();
    await box.put(_key, data);
  }

  Future<Box<String>> _box() async {
    if (_hiveBox == null) {
      await Hive.initFlutter();
      _hiveBox = await Hive.openBox("settings");
    }
    return _hiveBox;
  }
}
