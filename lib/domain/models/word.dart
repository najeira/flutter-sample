import 'package:meta/meta.dart';

@immutable
class Word {
  const Word({
    @required this.word,
    @required this.japanese,
    @required this.pronunciation,
    this.explanation,
  })  : assert(word != null),
        assert(japanese != null),
        assert(pronunciation != null);

  final String word;

  final String japanese;

  final String pronunciation;

  final String explanation;
}
