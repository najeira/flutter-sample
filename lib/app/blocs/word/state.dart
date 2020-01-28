import 'package:flutter_sample/domain/models/word.dart';

abstract class WordState {
  const WordState(this.word);

  final Word word;
}

class WordInital extends WordState {
  const WordInital() : super(null);
}

class WordLoadProgress extends WordState {
  const WordLoadProgress(Word word) : super(word);
}

class WordLoadSuccess extends WordState {
  const WordLoadSuccess(Word word) : super(word);
}
