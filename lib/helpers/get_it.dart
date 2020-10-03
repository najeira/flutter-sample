import 'package:get_it/get_it.dart';

import 'package:flutter_sample/domain/domain.dart';
import 'package:flutter_sample/infra/infra.dart';

T getIt<T>([String instanceName]) {
  return GetIt.instance.get<T>(instanceName);
}

void registerServices() {
  GetIt.instance.registerSingleton<ConfigRepository>(ConfigRepository());
  GetIt.instance.registerSingleton<RemoteRepository>(const RemoteRepository());
  GetIt.instance.registerSingleton<ConfigService>(const ConfigService());
  GetIt.instance.registerSingleton<ArticleService>(const ArticleService());
}
