import '../_imports.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage._({
    Key key,
  }) : super(key: key);

  static Future<void> push(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => const ConfigPage._(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return const SubjectProvider<Config>(
      id: kConfigID,
      child: ConfigHandler(
        builder: _buildWithState,
      ),
    );
  }

  static Widget _buildWithState(BuildContext context, ConfigState state, Widget child) {
    final bool loading = state is ConfigLoading || state is ConfigInitial;
    return Stack(
      children: <Widget>[
        child,
        if (loading) const CircularProgressIndicator(),
      ],
    );
  }
}

class ConfigScaffold extends StatelessWidget {
  const ConfigScaffold({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("設定"),
      ),
      body: const SingleChildScrollView(
        child: SubjectBuilder<Config>(
          id: kConfigID,
          builder: _buildWithSubject,
        ),
      ),
    );
  }

  static Widget _buildWithSubject(BuildContext context, StoredSubject<Config> subject, Widget child) {
    return Column(
      children: <Widget>[
        SwitchListTile(
          title: const Text("ダーク・モード"),
          value: subject.value.darkTheme,
          onChanged: (bool value) {
            // イベントの発生箇所は現在の状態を知る必要がない
            // 発生したイベントをdispatchし、ハンドラが現在の状態に応じて処理を行う
            const ConfigThemeChange().dispatch(context);
          },
        ),
      ],
    );
  }
}
