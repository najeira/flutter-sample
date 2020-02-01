import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_sample/domain/models/app_config.dart';
import 'package:flutter_sample/helpers/logger.dart';

class AppConfigRepository {
  AppConfigRepository();

  static const String _key = "app_config";

  Future<Box<String>> _hiveBox;

  Future<AppConfig> load() async {
    final Box<String> box = await _box();
    final String data = box.get(_key);
    if (data == null || data.isEmpty) {
      logger.info("new AppConfig");
      return const AppConfig.inital();
    }
    logger.info("load AppConfig");
    return AppConfig.fromJson(json.decode(data) as Map<String, dynamic>);
  }

  Future<void> save(AppConfig config) async {
    logger.info("save AppConfig");
    final Box<String> box = await _box();
    final String data = json.encode(config);
    await box.put(_key, data);
  }

  Future<Box<String>> _box() async {
    if (_hiveBox == null) {
      await Hive.initFlutter();
      _hiveBox = Hive.openBox<String>("settings");
    }
    return await _hiveBox;
  }
}
