import '_imports.dart';

class ConfigService {
  const ConfigService();

  Future<Config> load() {
    final ConfigRepository repo = getIt<ConfigRepository>();
    return repo.load();
  }

  Future<void> save(Config config) async {
    final ConfigRepository repo = getIt<ConfigRepository>();
    return repo.save(config);
  }
}
