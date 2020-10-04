import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sample/app/states/config.dart';
import 'package:flutter_sample/domain/domain.dart';
import 'package:flutter_sample/domain/models/models.dart';
import 'package:flutter_sample/helpers/get_it.dart';
import 'package:flutter_sample/helpers/logger.dart';

/// サンプルアプリではひとつのリストしかないので
/// 単一の Provider でよい
/// 複数タブの場合などは family を使う
/// ignore: always_specify_types
final articleListProvider = FutureProvider<ArticleList>((ref) async {
  logger.info("articleListProvider");
  final ArticleService svc = getIt<ArticleService>();
  return await svc.articleList();
});

/// 保存された [Config] を読み込む
/// ignore: always_specify_types
final storedConfigProvider = FutureProvider<Config>((ref) async {
  logger.info("_storedConfigProvider");

  // 読み込みはすぐにおわってしまうが
  // 分かりやすくするためすこし待たせる
  await Future<void>.delayed(const Duration(seconds: 1));

  // 保存したConfigを読み込む
  final ConfigService svc = getIt<ConfigService>();
  final Config config = await svc.load();
  assert(config != null);
  return config;
});

// ignore: always_specify_types
final configNotifierProvider = StateNotifierProvider<ConfigNotifier>((ref) {
  logger.info("configProvider");
  return ConfigNotifier(null);
});
