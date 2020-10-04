import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sample/app/providers.dart';
import 'package:flutter_sample/app/helpers/datetime.dart';
import 'package:flutter_sample/app/widgets/indicator.dart';
import 'package:flutter_sample/domain/models/models.dart';
import 'package:flutter_sample/helpers/logger.dart';

import '../config/config.dart';

import 'detail.dart';

/// [ArticleListTile] で表示される [Article] を提供する
final ScopedProvider<Article> _articleProvider = ScopedProvider<Article>(null);

class ArticleListPage extends ConsumerWidget {
  const ArticleListPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    logger.info("${runtimeType}.build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top headlines"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _onSettingsTap(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.refresh(articleListProvider),
        child: const ArticleListView(),
      ),
    );
  }

  void _onSettingsTap(BuildContext context) {
    ConfigPage.push(context);
  }
}

class ArticleListView extends ConsumerWidget {
  const ArticleListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    logger.info("${runtimeType}.build");
    final AsyncValue<ArticleList> future = watch(articleListProvider);
    return future.when<Widget>(
      data: (ArticleList data) {
        return _buildList(context, data);
      },
      loading: () {
        return _buildLoading(context);
      },
      error: (Object error, StackTrace stackTrace) {
        logger.errorException(error, stackTrace);
        return _buildError(context, error);
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return ListView(
      children: const <Widget>[
        MyIndicator(),
      ],
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return ListView(
      children: <Widget>[
        ErrorWidget(error),
      ],
    );
  }

  Widget _buildList(BuildContext context, ArticleList articleList) {
    final int count = articleList?.articles?.length ?? 0;
    return ListView.separated(
      itemCount: count + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == count) {
          return const _ListTail();
        } else if (index > count) {
          // itemCountを指定しているのでここには来ないはず
          return null;
        }

        final Article article = articleList.articles[index];
        return ProviderScope(
          overrides: <Override>[
            _articleProvider.overrideWithValue(article),
          ],
          child: const ArticleListTile(),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}

class ArticleListTile extends ConsumerWidget {
  const ArticleListTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Article article = watch(_articleProvider);
    logger.info("${runtimeType}.build ${article?.title}");
    return ListTile(
      title: Text(article.title),
      subtitle: Text(formatDateTimeString(article.publishedAt)),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        ArticleDetailPage.push(context, article);
      },
    );
  }
}

class _ListTail extends StatelessWidget {
  const _ListTail();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text("powered by newsapi.org"),
          ],
        ),
      ),
    );
  }
}
