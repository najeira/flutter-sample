import '_imports.dart';

import 'article/list.dart';

// アプリの設定やグローバルな状態を扱う
// このクラス自体はUIを持たない
class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  static const PageTransitionsTheme _pageTransitionsTheme = PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    },
  );

  @override
  Widget build(BuildContext context) {
    return const SubjectBuilder<Config>(
      id: kConfigID,
      builder: _buildWithSubject,
      child: ConfigHandler(
        builder: _buildWithState,
      ),
    );
  }

  static Widget _buildWithSubject(BuildContext context, StoredSubject<Config> subject, Widget child) {
    final Config config = subject.value ?? const Config.inital();
    final ThemeData theme = ThemeData.from(
      colorScheme: config.darkTheme ? const ColorScheme.dark() : const ColorScheme.light(),
    );

    return MaterialApp(
      theme: theme.copyWith(
        pageTransitionsTheme: _pageTransitionsTheme,
      ),
      home: ListenableProvider<StoredSubject<Config>>.value(
        value: subject,
        child: child,
      ),
    );
  }

  static Widget _buildWithState(BuildContext context, ConfigState state, Widget child) {
    final bool initial = state is ConfigInitial;
    return initial ? const StartPage() : const ArticleListPage();
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
