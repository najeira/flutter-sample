import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store_builder/store_builder.dart';

import 'package:flutter_sample/app/blocs/blocs.dart';
import 'package:flutter_sample/app/helpers/datetime.dart';
import 'package:flutter_sample/app/helpers/enum.dart';
import 'package:flutter_sample/app/helpers/provider.dart';
import 'package:flutter_sample/domain/models/models.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage._({
    Key key,
  }) : super(key: key);

  static Future<void> push(BuildContext context, Article article) {
    return Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        // 対象Articleのidと関連付けておく
        return Provider<int>.value(
          value: article.id,
          child: const ArticleDetailPage._(),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return const ArticleDetailHandler(
      builder: _buildWithState,
      child: ArticleDetailScaffold(),
    );
  }

  static Widget _buildWithState(BuildContext context, ArticleDetailState state, Widget child) {
    return Stack(
      children: <Widget>[
        child,
        if (state is ArticleDetailLoading) const CircularProgressIndicator(),
      ],
    );
  }
}

class ArticleDetailScaffold extends StatelessWidget {
  const ArticleDetailScaffold({
    Key key,
  }) : super(key: key);

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
      floatingActionButton: SubjectProvider<Article>(
        id: Provider.of<int>(context, listen: true),
        child: ProxyProvider<Article, bool>(
          create: (BuildContext context) => false,
          update: (BuildContext context, Article article, bool previous) => article.favorite,
          child: const ArticleDetailFavoriteButton(),
        ),
      ),
    );
  }
}

class ArticleDetailFavoriteButton extends StatelessWidget {
  const ArticleDetailFavoriteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<bool>(
      builder: (BuildContext context, bool favorite, Widget child) {
        final ColorScheme colorScheme = Theme.of(context).colorScheme;
        return FloatingActionButton(
          backgroundColor: colorScheme.onBackground,
          foregroundColor: favorite ? colorScheme.secondary : null,
          child: Icon(
            favorite ? Icons.favorite : Icons.favorite_border,
          ),
          onPressed: () {
            const ArticleDetailFavorite().dispatch(context);
          },
        );
      },
    );
  }
}

class ArticleDetailView extends StatelessWidget {
  const ArticleDetailView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubjectBuilder<Article>(
      id: Provider.of<int>(context, listen: true),
      builder: _buildWithSubject,
    );
  }

  static Widget _buildWithSubject(BuildContext context, StoredSubject<Article> subject, Widget child) {
    final Article article = subject.value;
    debugPrint("ArticleDetailView ${article?.id}");

    final ThemeData theme = Theme.of(context);

    return ListView(
      children: <Widget>[
        Hero(
          tag: "article-title-${article.id}",
          child: Material(
            child: Text(
              article.title,
              style: theme.textTheme.headline5,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          article.caption,
          style: theme.textTheme.bodyText2,
        ),
        const SizedBox(height: 8.0),
        Text(
          formatDateTime(article.startAt),
          style: theme.textTheme.bodyText2,
        ),
        const SizedBox(height: 8.0),
        Text(
          article.place,
          style: theme.textTheme.bodyText2,
        ),
        const SizedBox(height: 8.0),
        Text(
          article.address,
          style: theme.textTheme.bodyText2,
        ),
      ],
    );
  }
}
