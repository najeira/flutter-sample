import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_sample/domain/models/app_config.dart';

class AppConfigRepository {
  AppConfigRepository();

  static const String _key = "app_config";

  Future<void> _initHive;

  Future<AppConfig> load() async {
    await _ensureInit();
    final Box<String> box = Hive.box<String>('settings');
    final String data = box.get(_key);
    if (data == null || data.isEmpty) {
      return const AppConfig.inital();
    }
    return AppConfig.fromJson(json.decode(data) as Map<String, dynamic>);
  }

  Future<void> save(AppConfig config) async {
    await _ensureInit();
    final Box<String> box = Hive.box<String>('settings');
    final String data = json.encode(config);
    await box.put(_key, data);
  }

  Future<void> _ensureInit() async {
    if (_initHive == null) {
      await Hive.initFlutter();
      _initHive = Hive.openBox("settings");
      await _initHive;
    }
  }
}
