import '_imports.dart';

class AppConfigService {
  const AppConfigService();

  Future<AppConfig> load() async {
    return AppConfig.inital();
  }

  Future<void> save(AppConfig data) async {
    
  }
}
