import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sample/app/providers.dart';
import 'package:flutter_sample/app/states/config.dart';
import 'package:flutter_sample/domain/domain.dart';
import 'package:flutter_sample/helpers/logger.dart';

import 'article/list.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<AsyncValue<Config>>(
      onChange: (BuildContext context, AsyncValue<Config> data) {
        logger.info("ProviderListener.onChange");
        final ConfigNotifier notifier = context.read(configNotifierProvider);
        data.when(
          data: (Config value) => notifier.config = value,
          loading: () {},
          error: (_, __) => notifier.config = const Config(),
        );
      },
      provider: storedConfigProvider,
      child: const _MyApp(),
    );
  }
}

/// アプリの設定やグローバルな状態を扱う
/// このクラス自体はUIを持たない
class _MyApp extends ConsumerWidget {
  const _MyApp({
    Key key,
  }) : super(key: key);

  static const PageTransitionsTheme _cupertinoPageTransitionsTheme =
      PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    },
  );

  static const PageTransitionsTheme _androidPageTransitionsTheme =
      PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
    },
  );

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    logger.info("${runtimeType}.build");
    final Config config = watch(configNotifierProvider.state);
    final bool dark = config?.darkTheme ?? false;
    final bool android = config?.androidPageTransition ?? false;
    final ThemeData colorTheme = ThemeData.from(
      colorScheme: dark ? const ColorScheme.dark() : const ColorScheme.light(),
    );
    final ThemeData theme = colorTheme.copyWith(
      pageTransitionsTheme: android
          ? _androidPageTransitionsTheme
          : _cupertinoPageTransitionsTheme,
    );
    return MaterialApp(
      theme: theme,
      home: const _ConfigLoadingHandler(),
    );
  }
}

/// Configの読み込み状態に応じて [_WelcomePage] と [ArticleListPage] を切り替える
class _ConfigLoadingHandler extends ConsumerWidget {
  const _ConfigLoadingHandler({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    logger.info("${runtimeType}.build");
    final Config config = watch(configNotifierProvider.state);
    if (config == null) {
      return const _WelcomePage();
    }
    return const ArticleListPage();
  }
}

/// Launch screen
class _WelcomePage extends StatelessWidget {
  const _WelcomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.info("${runtimeType}.build");
    return const Scaffold(
      body: Center(
        child: Text(
          "Flutter News App",
          style: TextStyle(
            fontSize: 34.0,
          ),
        ),
      ),
    );
  }
}
