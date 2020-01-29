import 'package:bloc/bloc.dart';

import 'package:flutter_sample/app/helpers/service_locator.dart';

import 'package:flutter_sample/domain/domain.dart';

import 'event.dart';
import 'state.dart';

class ArticleListBloc extends Bloc<ArticleListEvent, ArticleListState> {
  ArticleListBloc()
      : initialState = const ArticleListInital(),
        super();

  @override
  final ArticleListState initialState;

  @override
  Stream<ArticleListState> mapEventToState(ArticleListEvent event) async* {
    if (event is ArticleListStart) {
      yield ArticleListLoadProgress(state.data);
      final ArticleService svc = getIt<ArticleService>();
      final ArticleList next = await svc.articleList();
      yield ArticleListLoadSuccess(next);
    } else if (event is ArticleListNext) {
      yield ArticleListLoadProgress(state.data);
      final ArticleService svc = getIt<ArticleService>();
      final ArticleList next = await svc.articleList();
      final ArticleList combine = ArticleList(
        state.data.start,
        state.data.count + next.count,
        next.total,
        state.data.articles..addAll(next.articles),
      );
      yield ArticleListLoadSuccess(combine);
    }
  }
}
