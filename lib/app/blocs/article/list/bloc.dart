import 'package:flutter/material.dart';

import 'package:notification_handler/notification_handler.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store_builder/store_builder.dart';

import 'package:flutter_sample/app/helpers/provider.dart';
import 'package:flutter_sample/domain/domain.dart';
import 'package:flutter_sample/helpers/get_it.dart';
import 'package:flutter_sample/helpers/logger.dart';

import 'event.dart';
import 'state.dart';

class ArticleListHandler extends SingleChildStatelessWidget {
  const ArticleListHandler({
    Key key,
    this.builder,
    Widget child,
  })  : assert(builder != null || child != null),
        super(
          key: key,
          child: child,
        );

  final NotificationHandlerWidgetBuilder<ArticleListState> builder;

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return NotificationHandler<ArticleListEvent, ArticleListState>(
      initialState: const ArticleListInital(),
      onInit: onInit,
      onEvent: onEvent,
      builder: builder,
      child: child,
    );
  }

  void onInit(BuildContext context) {
    final StoredSubject<ArticleList> subject = subjectOf<ArticleList>(context);
    if (!subject.hasValue) {
      const ArticleListStart().dispatch(context);
    }
  }

  Stream<ArticleListState> onEvent(BuildContext context, ArticleListEvent event) async* {
    final StoredSubject<ArticleList> subject = subjectOf<ArticleList>(context, listen: false);
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
