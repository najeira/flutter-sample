import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sample/app/helpers/datetime.dart';
import 'package:flutter_sample/domain/models/models.dart';
import 'package:flutter_sample/helpers/logger.dart';

final ScopedProvider<Article> _articleProvider = ScopedProvider<Article>(null);

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage._({
    Key key,
  }) : super(key: key);

  static Future<void> push(BuildContext context, Article article) {
    return Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        // 対象Articleと関連付けておく
        return ProviderScope(
          overrides: <Override>[
            _articleProvider.overrideWithValue(article),
          ],
          child: const ArticleDetailPage._(),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return const ArticleDetailScaffold();
  }
}

class ArticleDetailScaffold extends ConsumerWidget {
  const ArticleDetailScaffold({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Article article = watch(_articleProvider);
    logger.info("${runtimeType}.build");
    return Scaffold(
      appBar: AppBar(
        title: Text(article.author ?? ""),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: ArticleDetailView(),
      ),
    );
  }
}

class ArticleDetailView extends ConsumerWidget {
  const ArticleDetailView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    logger.info("${runtimeType}.build");
    final Article article = watch(_articleProvider);
    final ThemeData theme = Theme.of(context);
    return ListView(
      children: <Widget>[
        Text(
          formatDateTimeString(article.publishedAt),
          style: theme.textTheme.caption,
        ),
        const SizedBox(height: 8.0),
        Text(
          article.title ?? "-",
          style: theme.textTheme.headline5,
        ),
        const SizedBox(height: 8.0),
        ArticleImage(article.urlToImage),
        const SizedBox(height: 8.0),
        Text(
          article.description ?? "-",
          style: theme.textTheme.bodyText2,
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text("詳しく見る"),
              SizedBox(width: 4.0),
              Icon(Icons.open_in_new),
            ],
          ),
          onPressed: () async {
            if (await canLaunch(article.url)) {
              await launch(article.url);
            }
          },
        ),
      ],
    );
  }
}

class ArticleImage extends StatelessWidget {
  const ArticleImage(
    this.src, {
    Key key,
  }) : super(key: key);

  final String src;

  @override
  Widget build(BuildContext context) {
    if (src == null || src.isEmpty) {
      return const SizedBox();
    }
    final MediaQueryData media = MediaQuery.of(context);
    final double width = media.size.width - 32.0;
    final double height = width * 9.0 / 16.0;
    return Image.network(
      src,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
