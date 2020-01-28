import 'dart:math';

import 'package:flutter_sample/domain/models/word.dart';

import 'data.dart';

class WordService {
  WordService() : rand = Random(DateTime.now().microsecondsSinceEpoch);

  final Random rand;

  Future<Word> next() async {
    final int n = rand.nextInt(words.length);
    await Future<void>.delayed(const Duration(seconds: 1));
    return words[n];
  }
}
