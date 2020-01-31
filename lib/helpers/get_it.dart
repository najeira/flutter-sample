import 'package:get_it/get_it.dart';

T getIt<T>([String instanceName]) {
  return GetIt.instance.get<T>(instanceName);
}
