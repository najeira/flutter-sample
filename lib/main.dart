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

  GetIt.instance.registerSingleton(Store());

  GetIt.instance.registerSingleton(const RemoteRepository(
    "connpass.com",
    "/api/v1/event/",
  ));

  GetIt.instance.registerSingleton(const ArticleService());

  FlutterError.onError = (FlutterErrorDetails error) {
    logger.error(error.exceptionAsString());
  };

  runZoned<Future<void>>(
    () async {
      runApp(AppRoot.bloc());
    },
    onError: (Object ex, StackTrace st) {
      logger.errorException(ex, st);
    }
  );
}
