import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store_builder/store_builder.dart';

import 'package:flutter_sample/app/blocs/blocs.dart';
import 'package:flutter_sample/app/helpers/enum.dart';
import 'package:flutter_sample/app/helpers/provider.dart';
import 'package:flutter_sample/domain/models/models.dart';
import 'package:flutter_sample/helpers/logger.dart';

import 'article/list.dart';

// アプリの設定やグローバルな状態を扱う
// このクラス自体はUIを持たない
class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ConfigはThemeを変更するのでルート付近でprovideしておく
    return const SubjectProvider<Config>(
      id: kConfigID,
      child: _MyAppWithConfig(
        child: _StartOrArticleListPage(),
      ),
    );
  }
}

// Configに応じてThemeを設定する
class _MyAppWithConfig extends SingleChildStatelessWidget {
  const _MyAppWithConfig({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  static const PageTransitionsTheme _cupertinoPageTransitionsTheme = PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    },
  );

  static const PageTransitionsTheme _androidPageTransitionsTheme = PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
    },
  );

  static const Config _defaultConfig = Config.inital();

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    final Config config = valueOf<Config>(context, listen: true) ?? _defaultConfig;

    final ThemeData theme = ThemeData.from(
      colorScheme: config.darkTheme
          ? const ColorScheme.dark() : const ColorScheme.light(),
    );

    final PageTransitionsTheme pageTransitionsTheme = config.androidPageTransition
        ? _androidPageTransitionsTheme : _cupertinoPageTransitionsTheme;

    return MaterialApp(
      theme: theme.copyWith(
        pageTransitionsTheme: pageTransitionsTheme,
      ),
      home: child,
    );
  }
}

// Configの読み込み状態に応じてStartPageとArticleListPageを切り替える
class _StartOrArticleListPage extends StatelessWidget {
  const _StartOrArticleListPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfigHandler(
      builder: (BuildContext context, ConfigState state, Widget child) {
        final bool loading = state is! ConfigSuccess;
        return loading ? const StartPage() : const ArticleListPage();
      },
    );
  }
}

// Launch screen
class StartPage extends StatelessWidget {
  const StartPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Flutter勉強会",
          style: TextStyle(
            fontSize: 34.0,
          ),
        ),
      ),
    );
  }
}
