import '_imports.dart';

class AppConfigService {
  const AppConfigService();

  Future<AppConfig> load() {
    final AppConfigRepository repo = getIt<AppConfigRepository>();
    return repo.load();
  }

  Future<void> save(AppConfig config) async {
    final AppConfigRepository repo = getIt<AppConfigRepository>();
    return repo.save(config);
  }
}
