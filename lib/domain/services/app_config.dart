import '_imports.dart';

class AppConfigService {
  const AppConfigService();

  Future<AppConfig> load() async {
    // 読み込みはすぐにおわってしまうが
    // 分かりやすくするためすこし待たせる
    await Future<void>.delayed(const Duration(seconds: 1));

    final AppConfigRepository repo = getIt<AppConfigRepository>();
    return await repo.load();
  }

  Future<void> save(AppConfig config) async {
    final AppConfigRepository repo = getIt<AppConfigRepository>();
    return await repo.save(config);
  }
}
