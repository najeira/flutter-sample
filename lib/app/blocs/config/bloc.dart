import 'dart:async';

import 'package:flutter/material.dart';

import 'package:notification_handler/notification_handler.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store_builder/store_builder.dart';

import 'package:flutter_sample/app/helpers/provider.dart';
import 'package:flutter_sample/domain/domain.dart';
import 'package:flutter_sample/helpers/get_it.dart';

import 'event.dart';
import 'state.dart';

class ConfigHandler extends SingleChildStatelessWidget {
  const ConfigHandler({
    Key key,
    @required this.builder,
    Widget child,
  }) : super(
          key: key,
          child: child,
        );

  final NotificationHandlerWidgetBuilder<ConfigState> builder;

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return NotificationHandler<ConfigEvent, ConfigState>(
      initialState: const ConfigInitial(),
      onInit: onInit,
      onEvent: onEvent,
      builder: builder,
      child: child,
    );
  }

  void onInit(BuildContext context) {
    final StoredSubject<Config> subject = subjectOf<Config>(context);
    if (!subject.hasValue) {
      const ConfigStart().dispatch(context);
    }
  }

  Stream<ConfigState> onEvent(BuildContext context, ConfigEvent event) async* {
    // Configは単一なので状態に依存しないが
    // 通常はイベント発生時の状態と合わせて処理を行う
    // このメソッドは非同期のため途中で親のsubjectが変更になりうる
    // そのため先頭でイベント発生時のsubjectを得ておく必要がある
    // この実装はミスが起こりやすいので仕組みを検討中
    // subjectを更新することで値に依存する子孫widgetが再構築される
    // ハンドラが返すConfigStateは最新の値とは別の途中経過のために使う
    final StoredSubject<Config> subject = subjectOf<Config>(context, listen: false);

    if (event is ConfigStart) {
      yield const ConfigLoading();

      // 読み込みはすぐにおわってしまうが
      // 分かりやすくするためすこし待たせる
      await Future<void>.delayed(const Duration(seconds: 1));

      // 保存したConfigを読み込む
      // 複数の状態がある場合はsubjectからIDを得るなどする
      // final data = await svc.load(subject.value.id);
      final ConfigService svc = getIt<ConfigService>();
      final Config data = await svc.load();

      // subjectを更新すると下位のwidgetが更新される
      subject.value = data;

      yield const ConfigSuccess();
    } else if (event is ConfigThemeChange) {
      _updateDarkTheme(subject, !subject.value.darkTheme);
    }
  }

  Stream<ConfigState> _updateDarkTheme(StoredSubject<Config> subject, bool darkTheme) async* {
    yield const ConfigLoading();

    // 分かりやすくするためすこし待たせる
    await Future<void>.delayed(const Duration(seconds: 1));

    _updateSubjectAndSave(
      subject,
      subject.value.copyWith(
        darkTheme: darkTheme,
      ),
    );

    yield const ConfigSuccess();
  }

  Future<void> _updateSubjectAndSave(StoredSubject<Config> subject, Config data) {
    subject.value = data;
    return _save(data);
  }

  Future<void> _save(Config data) {
    final ConfigService svc = getIt<ConfigService>();
    return svc.save(data);
  }
}
