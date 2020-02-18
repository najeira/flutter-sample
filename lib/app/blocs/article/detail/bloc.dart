import 'dart:async';

import '../../_imports.dart';

import 'event.dart';
import 'state.dart';

class ArticleDetailHandler extends AppEventHandler<ArticleDetailEvent, ArticleDetailState> {
  const ArticleDetailHandler({
    Key key,
    @required AppStateWidgetBuilder<ArticleDetailState> builder,
    Widget child,
  }) : super(
          key: key,
          builder: builder,
          child: child,
        );

  @override
  ArticleDetailState get initialState {
    return const ArticleDetailInital();
  }

  @override
  Stream<ArticleDetailState> onEvent(BuildContext context, ArticleDetailEvent event) async* {
    final StoredSubject<Article> subject = subjectOf<Article>(context);

    if (event is ArticleDetailStart) {
      // このサンプルでは詳細のロードは必要ないが
      // 例としてダミーのdelayを入れておく
      yield const ArticleDetailLoading();
      await Future<void>.delayed(const Duration(seconds: 1));
      subject.value = subject.value;
      yield const ArticleDetailSuccess();

    } else if (event is ArticleDetailFavorite) {
      final Article article = subject.value;
      article.favorite = !article.favorite;
      subject.value = article;

    }
  }
}
