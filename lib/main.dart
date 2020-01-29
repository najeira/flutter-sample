import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:flutter_sample/app/pages/home.dart';
import 'package:flutter_sample/domain/domain.dart';
import 'package:flutter_sample/infra/infra.dart';

void main() {
  final RemoteRepository repository = RemoteRepository(
    "connpass.com",
    "/api/v1/event/",
  );
  GetIt.instance.registerSingleton(ArticleService(repository));

  runApp(MaterialApp(
    theme: ThemeData.dark().copyWith(
      dividerTheme: const DividerThemeData(
        space: 1.0,
        thickness: 1.0,
      ),
    ),
    home: ArticleListPage(),
  ));
}
