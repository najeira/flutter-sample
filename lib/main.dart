import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter_sample/app/pages/home.dart';
import 'package:flutter_sample/domain/domain.dart';
import 'package:flutter_sample/infra/infra.dart';

void main() {
  initializeDateFormatting("ja_JP");

  GetIt.instance.registerSingleton(const RemoteRepository(
    "connpass.com",
    "/api/v1/event/",
  ));

  GetIt.instance.registerSingleton(const ArticleService());

  runApp(MaterialApp(
    theme: ThemeData.dark().copyWith(
      accentColor: Colors.amberAccent,
    ),
    home: ArticleListPage(),
  ));
}
