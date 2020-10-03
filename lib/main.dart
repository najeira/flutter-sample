import 'dart:async';

import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sample/app/pages/app_root.dart';
import 'package:flutter_sample/helpers/get_it.dart';
import 'package:flutter_sample/helpers/logger.dart';

void main() {
  initializeDateFormatting("ja_JP");

  registerServices();

  FlutterError.onError = (FlutterErrorDetails error) {
    logger.error(error.exceptionAsString());
  };

  runZoned<Future<void>>(() async {
    runApp(const ProviderScope(
      child: MyApp(),
    ));
  }, onError: (Object ex, StackTrace st) {
    logger.errorException(ex, st);
  });
}
