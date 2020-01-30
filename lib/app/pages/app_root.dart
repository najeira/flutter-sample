import '_imports.dart';

import 'article/list.dart';

// アプリの設定やグローバルな状態を扱う
// このクラス自体はUIを持たない
class AppRoot extends StatelessWidget {
  const AppRoot._({
    Key key,
  }) : super(key: key);

  static const PageTransitionsTheme _pageTransitionsTheme = PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    },
  );

  static Widget bloc() {
    return BlocProvider<AppConfigBloc>(
      create: (BuildContext context) => AppConfigBloc()..add(const AppConfigStart()),
      child: const AppRoot._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConfigBloc, AppConfigState>(
      builder: (BuildContext context, AppConfigState state) {
        return _build(context, state.data);
      },
    );
  }

  Widget _build(BuildContext context, AppConfig config) {
    final ThemeData theme = ThemeData.from(
      colorScheme: config.darkTheme ? const ColorScheme.dark() : const ColorScheme.light(),
    );

    return MaterialApp(
      theme: theme.copyWith(
        pageTransitionsTheme: _pageTransitionsTheme,
      ),
      home: const ArticleListPage(),
    );
  }
}
