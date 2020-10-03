import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sample/app/providers.dart';
import 'package:flutter_sample/app/states/config.dart';
import 'package:flutter_sample/helpers/logger.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("設定"),
      ),
      body: const SingleChildScrollView(
        child: ConfigColumn(),
      ),
    );
  }
}

class ConfigColumn extends ConsumerWidget {
  const ConfigColumn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final ConfigController data = watch(configProvider);
    logger.info("${runtimeType}.build");
    return Column(
      children: <Widget>[
        SwitchListTile(
          title: const Text("ダーク・モード"),
          value: data.config.darkTheme,
          onChanged: (bool value) {
            context.read(configProvider).setDarkTheme(value);
          },
        ),
        SwitchListTile(
          title: const Text("Android風ページ遷移"),
          value: data.config.androidPageTransition,
          onChanged: (bool value) {
            context.read(configProvider).setAndroidPageTransition(value);
          },
        ),
      ],
    );
  }
}
