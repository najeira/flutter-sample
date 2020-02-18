import '../../_imports.dart';

import 'event.dart';
import 'state.dart';

class ArticleListHandler extends AppEventHandler<ArticleListEvent, ArticleListState> {
  const ArticleListHandler({
    Key key,
    Widget child,
  }) : super(
          key: key,
          child: child,
        );

  @override
  ArticleListState get initialState {
    return const ArticleListInital();
  }

  @override
  void onInit(BuildContext context) {
    final StoredSubject<ArticleList> subject = subjectOf<ArticleList>(context);
    if (!subject.hasValue) {
      const ArticleListStart().dispatch(context);
    }
  }

  @override
  Stream<ArticleListState> onEvent(BuildContext context, ArticleListEvent event) async* {
    final StoredSubject<ArticleList> subject = subjectOf<ArticleList>(context);
    final ArticleList current = subject.value;

    if (event is ArticleListStart) {
      yield const ArticleListLoading();

      final ArticleService svc = getIt<ArticleService>();
      try {
        subject.value = await svc.articleList();
        yield const ArticleListSuccess();

      } catch (ex, st) {
        logger.errorException(ex, st);

        // 時間をおいてからリトライ
        await Future<void>.delayed(const Duration(seconds: 3));
        event.dispatch(context);
      }

    } else if (event is ArticleListNext) {
      yield const ArticleListLoading();

      final ArticleService svc = getIt<ArticleService>();
      try {
        final ArticleList next = await svc.articleList(current);
        if (next != null) {
          subject.value = ArticleList(
            current.start,
            current.count + next.count,
            next.total,
            current.articles..addAll(next.articles),
          );
          yield const ArticleListSuccess();

        } else {
          // 末尾まで読み込んだ
          yield const ArticleListFinish();

        }
      } catch (ex, st) {
        logger.errorException(ex, st);
        yield const ArticleListSuccess();

      }
    }
  }
}
