import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sample/app/states/config.dart';
import 'package:flutter_sample/domain/domain.dart';
import 'package:flutter_sample/domain/models/models.dart';
import 'package:flutter_sample/helpers/get_it.dart';
import 'package:flutter_sample/helpers/logger.dart';

// ignore: always_specify_types
final articleListProvider = FutureProvider<ArticleList>((ref) async {
  logger.info("articleListProvider");
  final ArticleService svc = getIt<ArticleService>();
  return await svc.articleList();
});

// ignore: always_specify_types
final _configProvider = FutureProvider<Config>((ref) async {
  logger.info("_configProvider");

  // 読み込みはすぐにおわってしまうが
  // 分かりやすくするためすこし待たせる
  await Future<void>.delayed(const Duration(seconds: 1));

  // 保存したConfigを読み込む
  // 複数の状態がある場合はsubjectからIDを得るなどする
  // final data = await svc.load(subject.value.id);
  final ConfigService svc = getIt<ConfigService>();
  final Config config = await svc.load();
  return config;
});

// ignore: always_specify_types
final configProvider = StateNotifierProvider<ConfigController>((ref) {
  logger.info("configProvider");
  final AsyncValue<Config> future = ref.watch(_configProvider);
  return future.when(
    data: (Config data) {
      return ConfigController(data);
    },
    loading: () {
      return ConfigController(null);
    },
    error: (Object error, StackTrace stackTrace) {
      return ConfigController(const Config());
    },
  );
});
