import '_imports.dart';

import 'article/list.dart';

// アプリの設定やグローバルな状態を扱う
// このクラス自体はUIを持たない
class MyApp extends StatelessWidget {
  const MyApp._({
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
      child: const MyApp._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConfigBloc, AppConfigState>(
      builder: (BuildContext context, AppConfigState state) {
        return _build(context, state);
      },
    );
  }

  Widget _build(BuildContext context, AppConfigState state) {
    final AppConfig config = state.data;
    final ThemeData theme = ThemeData.from(
      colorScheme: config.darkTheme ? const ColorScheme.dark() : const ColorScheme.light(),
    );

    final bool initial = state is AppConfigInitial;
    final StatelessWidget child = initial ? const StartPage() : const ArticleListPage();

    return MaterialApp(
      theme: theme.copyWith(
        pageTransitionsTheme: _pageTransitionsTheme,
      ),
      home: child,
    );
  }
}

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
