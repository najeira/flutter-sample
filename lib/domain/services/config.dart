import 'package:flutter_sample/domain/models/models.dart';
import 'package:flutter_sample/helpers/get_it.dart';
import 'package:flutter_sample/infra/infra.dart';

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
