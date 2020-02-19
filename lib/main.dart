import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:store_builder/store_builder.dart';

import 'package:flutter_sample/app/pages/app_root.dart';
import 'package:flutter_sample/domain/domain.dart';
import 'package:flutter_sample/helpers/logger.dart';
import 'package:flutter_sample/infra/infra.dart';

void main() {
  initializeDateFormatting("ja_JP");

  registerServices();

  FlutterError.onError = (FlutterErrorDetails error) {
    logger.error(error.exceptionAsString());
  };

  runZoned<Future<void>>(() async {
    runApp(StoreProvider(
      store: Store(),
      child: const MyApp(),
    ));
  }, onError: (Object ex, StackTrace st) {
    logger.errorException(ex, st);
  });
}

void registerServices() {
  GetIt.instance.registerSingleton<Store>(Store());
  GetIt.instance.registerSingleton<ConfigRepository>(ConfigRepository());
  GetIt.instance.registerSingleton<RemoteRepository>(const RemoteRepository(
    "connpass.com",
    "/api/v1/event/",
  ));
  GetIt.instance.registerSingleton<ConfigService>(const ConfigService());
  GetIt.instance.registerSingleton<ArticleService>(const ArticleService());
}
