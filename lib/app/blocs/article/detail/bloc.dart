import 'dart:async';

import '../../_imports.dart';

import 'event.dart';
import 'state.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  ArticleDetailBloc(Article article)
      : _subject = getIt<Store>().use(article.id, seedValue: article),
        super() {
    _subscription = _subject.listen(_onData);
  }

  @override
  ArticleDetailState get initialState => ArticleDetailInital(_subject.value);

  final StoredSubject<Article> _subject;

  StreamSubscription<Article> _subscription;

  @override
  Stream<ArticleDetailState> mapEventToState(ArticleDetailEvent event) async* {
    if (event is ArticleDetailStart) {
      // このサンプルでは詳細のロードは必要ないが
      // 例としてダミーのdelayを入れておく
      yield ArticleDetailLoadProgress(state.data);
      await Future<void>.delayed(const Duration(seconds: 1));
      yield ArticleDetailLoadSuccess(state.data);
    } else if (event is ArticleDetailUpdate) {
      yield ArticleDetailLoadSuccess(state.data);
    } else if (event is ArticleDetailFavorite) {
      state.data.favorite = !state.data.favorite;
      _subject.value = state.data;
    }
  }

  void _onData(Article data) {
    add(ArticleDetailUpdate(data));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _subject?.release();
    return super.close();
  }
}
