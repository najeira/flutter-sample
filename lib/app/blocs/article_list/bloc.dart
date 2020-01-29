import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_sample/domain/domain.dart';

import 'package:flutter_sample/helpers/get_it.dart';

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
      try {
        final ArticleList next = await svc.articleList();
        yield ArticleListLoadSuccess(next);
      } catch (ex) {
        debugPrint(ex.toString());

        // 時間をおいてからリトライ
        await Future<void>.delayed(const Duration(seconds: 3));
        add(const ArticleListStart());
      }

    } else if (event is ArticleListNext) {
      if (state is! ArticleListLoadSuccess) {
        debugPrint("ignore ${state.runtimeType}");
        return;
      }

      yield ArticleListLoadProgress(state.data);

      final ArticleService svc = getIt<ArticleService>();
      try {
        final ArticleList next = await svc.articleList(state.data);
        if (next != null) {
          final ArticleList combine = ArticleList(
            state.data.start,
            state.data.count + next.count,
            next.total,
            state.data.articles..addAll(next.articles),
          );
          yield ArticleListLoadSuccess(combine);
        } else {
          // 末尾まで読み込んだ
          yield ArticleListLoadFinish(state.data);
        }
      } catch (ex) {
        debugPrint(ex.toString());
        yield ArticleListLoadSuccess(state.data);
      }
    }
  }
}
