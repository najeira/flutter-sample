import '../_imports.dart';

abstract class AppConfigState {
  const AppConfigState(this.data);

  final AppConfig data;
}

class AppConfigInitial extends AppConfigState {
  const AppConfigInitial(AppConfig data) : super(data);
}

class AppConfigLoadSuccess extends AppConfigState {
  const AppConfigLoadSuccess(AppConfig data) : super(data);
}
