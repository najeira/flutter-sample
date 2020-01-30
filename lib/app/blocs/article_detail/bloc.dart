import '../imports.dart';

import 'event.dart';
import 'state.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  ArticleDetailBloc(Article article)
      : initialState = ArticleDetailInital(article),
        super();

  @override
  final ArticleDetailState initialState;

  @override
  Stream<ArticleDetailState> mapEventToState(ArticleDetailEvent event) async* {
    if (event is ArticleDetailStart) {
      // このサンプルでは詳細のロードは必要ないが
      // 例としてダミーのdelayを入れておく
      yield ArticleDetailLoadProgress(state.data);
      await Future<void>.delayed(const Duration(seconds: 1));
      yield ArticleDetailLoadSuccess(state.data);
    }
  }
}
