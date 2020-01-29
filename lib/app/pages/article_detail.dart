import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_sample/app/blocs/blocs.dart';
import 'package:flutter_sample/app/helpers/datetime.dart';

import 'package:flutter_sample/domain/domain.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage();

  static Future<void> push(BuildContext context, Article article) {
    return Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => ArticleDetailPage.bloc(article),
    ));
  }

  static Widget bloc(Article article) {
    return BlocProvider<ArticleDetailBloc>(
      create: (BuildContext context) => ArticleDetailBloc(article)..add(const ArticleDetailStart()),
      child: const ArticleDetailPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter勉強会"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: ArticleDetailView(),
      ),
    );
  }
}

class ArticleDetailView extends StatelessWidget {
  const ArticleDetailView();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
      builder: (BuildContext context, ArticleDetailState state) {
        final Article article = state.data;
        debugPrint("ArticleDetailView ${article?.id}");
        return ListView(
          children: <Widget>[
            Hero(
              tag: "article-title-${article.id}",
              child: Material(
                child: Text(
                  article.title,
                  style: theme.textTheme.headline,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              article.caption,
              style: theme.textTheme.body1,
            ),
            const SizedBox(height: 8.0),
            Text(
              formatDateTime(article.startAt),
              style: theme.textTheme.body1,
            ),
            const SizedBox(height: 8.0),
            Text(
              article.place,
              style: theme.textTheme.body1,
            ),
            const SizedBox(height: 8.0),
            Text(
              article.address,
              style: theme.textTheme.body1,
            ),
          ],
        );
      },
    );
  }
}
