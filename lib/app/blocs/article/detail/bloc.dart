import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sample/helpers/logger.dart';

import 'package:notification_handler/notification_handler.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store_builder/store_builder.dart';

import 'package:flutter_sample/app/helpers/provider.dart';
import 'package:flutter_sample/domain/domain.dart';

import 'event.dart';
import 'state.dart';

class ArticleDetailHandler extends SingleChildStatelessWidget {
  const ArticleDetailHandler({
    Key key,
    this.builder,
    Widget child,
  })  : assert(builder != null || child != null),
        super(
          key: key,
          child: child,
        );

  final NotificationHandlerWidgetBuilder<ArticleDetailState> builder;

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return NotificationHandler<ArticleDetailEvent, ArticleDetailState>(
      initialState: const ArticleDetailInital(),
      onInit: null,
      onEvent: onEvent,
      builder: builder,
      child: child,
    );
  }

  Stream<ArticleDetailState> onEvent(BuildContext context, ArticleDetailEvent event) async* {
    logger.info("${runtimeType} ${event}");

    final StoredSubject<Article> subject = subjectOf<Article>(context, listen: false);

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
