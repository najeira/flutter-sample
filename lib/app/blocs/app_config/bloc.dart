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
      // 保存したAppConfigを読み込む
      final AppConfigService svc = getIt<AppConfigService>();
      final AppConfig data = await svc.load();
      _subject.value = data;

    } else if (event is AppConfigUpdate) {
      yield AppConfigActive(event.data);

    } else if (event is AppConfigDarkThemeSet) {
      // subjectを更新すると_onDataが呼ばれてイベントが発生する
      // 状態の更新はそのイベントのハンドラで行う
      _subject.value = _subject.value.copyWith(
        darkTheme: true,
      );
      _save(_subject.value);

    } else if (event is AppConfigLightThemeSet) {
      // subjectを更新すると_onDataが呼ばれてイベントが発生する
      // 状態の更新はそのイベントのハンドラで行う
      _subject.value = _subject.value.copyWith(
        darkTheme: false,
      );
      _save(_subject.value);

    }
  }

  Future<void> _save(AppConfig data) {
    final AppConfigService svc = getIt<AppConfigService>();
    return svc.save(data);
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
