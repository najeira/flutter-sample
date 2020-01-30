import '../_imports.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage._({
    Key key,
  }) : super(key: key);

  static Future<void> push(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => ConfigPage.bloc(),
    ));
  }

  static Widget bloc() {
    return BlocProvider<AppConfigBloc>(
      create: (BuildContext context) =>
      AppConfigBloc()
        ..add(const AppConfigStart()),
      child: const ConfigPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("設定"),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AppConfigBloc, AppConfigState>(
          builder: (BuildContext context, AppConfigState state) {
            return Column(
              children: <Widget>[
                SwitchListTile(
                  title: const Text("ダーク・モード"),
                  value: state.data.darkTheme,
                  onChanged: (bool value) {
                    final AppConfigBloc bloc = BlocProvider.of<AppConfigBloc>(context);
                    bloc.add(value ? const AppConfigDarkThemeSet() : const AppConfigLightThemeSet());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
