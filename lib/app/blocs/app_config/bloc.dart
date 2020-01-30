import 'dart:async';

import '../_imports.dart';

import 'event.dart';
import 'state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  AppConfigBloc()
      : _subject = getIt<Store>().use(0, seedValue: const AppConfig.inital()),
        super() {
    _subscription = _subject.listen(_onData);
  }

  @override
  AppConfigState get initialState => AppConfigInitial(_subject.value);

  final StoredSubject<AppConfig> _subject;

  StreamSubscription<AppConfig> _subscription;

  @override
  Stream<AppConfigState> mapEventToState(AppConfigEvent event) async* {
    if (event is AppConfigStart) {
      // TODO: 保存したAppConfigを読み込む
    } else if (event is AppConfigUpdate) {
      yield AppConfigLoadSuccess(event.data);
    } else if (event is AppConfigDarkThemeSet) {
      _subject.value = _subject.value.copyWith(
        darkTheme: true,
      );
    } else if (event is AppConfigLightThemeSet) {
      _subject.value = _subject.value.copyWith(
        darkTheme: false,
      );
    }
  }

  void _onData(AppConfig data) {
    add(AppConfigUpdate(data));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _subject?.release();
    return super.close();
  }
}
