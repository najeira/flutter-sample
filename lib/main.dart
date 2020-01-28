import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:flutter_sample/app/pages/home.dart';
import 'package:flutter_sample/domain/services/word.dart';

void main() {
  GetIt.instance.registerSingleton(WordService());

  runApp(MaterialApp(
    home: HomePage(),
  ));
}
