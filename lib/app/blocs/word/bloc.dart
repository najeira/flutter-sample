import 'package:bloc/bloc.dart';

import 'package:flutter_sample/app/helpers/service_locator.dart';

import 'package:flutter_sample/domain/models/word.dart';
import 'package:flutter_sample/domain/services/word.dart';

import 'event.dart';
import 'state.dart';

class WordShowBloc extends Bloc<WordEvent, WordState> {
  WordShowBloc()
      : initialState = const WordInital(),
        super();

  @override
  final WordState initialState;

  @override
  Stream<WordState> mapEventToState(WordEvent event) async* {
    if (event is WordNext) {
      yield WordLoadProgress(state.word);
      final WordService svc = getIt<WordService>();
      final Word next = await svc.next();
      yield WordLoadSuccess(next);
    }
  }
}
