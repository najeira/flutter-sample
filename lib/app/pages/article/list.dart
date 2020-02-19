import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store_builder/store_builder.dart';

import 'package:flutter_sample/app/blocs/blocs.dart';
import 'package:flutter_sample/app/helpers/datetime.dart';
import 'package:flutter_sample/app/helpers/enum.dart';
import 'package:flutter_sample/app/helpers/provider.dart';
import 'package:flutter_sample/domain/models/models.dart';
import 'package:flutter_sample/helpers/logger.dart';

import '../config/config.dart';

import 'detail.dart';

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubjectProvider<ArticleList>(
      id: kArticleListID,
      child: ArticleListHandler(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Flutter勉強会"),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => _onSettingsTap(context),
              ),
            ],
          ),
          body: const ArticleListView(),
        ),
      ),
    );
  }

  void _onSettingsTap(BuildContext context) {
    ConfigPage.push(context);
  }
}

class ArticleListView extends StatelessWidget {
  const ArticleListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleList>(
      builder: _buildWithValue,
    );
  }

  static Widget _buildWithValue(BuildContext context, ArticleList articleList, Widget child) {
    logger.info("ArticleListView ${articleList?.count}");

    final ArticleListState state = Provider.of<ArticleListState>(context, listen: true);
    final bool loading = state is ArticleListLoading || state is ArticleListInital;
    final bool hasNext = state is! ArticleListFinish;

    final int count = articleList?.articles?.length ?? 0;

    return ListView.separated(
      itemCount: count + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == count) {
          if (loading) {
            return const _ListLoading();
          }

          if (hasNext) {
            // 最後まで読み込んだので次へのイベントを発行する
            // 多重読み込みの防止はBloc側で行われる
            const ArticleListNext().dispatch(context);
          }

          return const _ListTail();
        } else if (index > count) {
          // itemCountを指定しているのでここには来ないはず
          return null;
        }

        final Article article = articleList.articles[index];
        return SubjectProvider<Article>(
          initalValue: article,
          id: article.id,
          child: const ArticleListTile(),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}

class ArticleListTile extends StatelessWidget {
  const ArticleListTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArticleDetailHandler(
      child: Consumer<Article>(
        builder: _buildWithValue,
      ),
    );
  }

  Widget _buildWithValue(BuildContext context, Article article, Widget child) {
    logger.info("${runtimeType}(${identityHashCode(this)}) ${article?.id}");

    return ListTile(
      title: Text(article.title),
      subtitle: Text(formatDateTime(article.startAt)),
      trailing: ProxyProvider<Article, bool>(
        create: (BuildContext context) => article.favorite,
        update: (BuildContext context, Article article, bool previous) => article.favorite,
        child: const ArticleListFavoriteButton(),
      ),
      onTap: () {
        // ここもイベントにするべきだろうか？
        ArticleDetailPage.push(context, article);
      },
    );
  }
}

class ArticleListFavoriteButton extends StatelessWidget {
  const ArticleListFavoriteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<bool>(
      builder: (BuildContext context, bool favorite, Widget child) {
        final Color accentColor = Theme.of(context).accentColor;
        return IconButton(
          icon: Icon(
            favorite ? Icons.favorite : Icons.favorite_border,
            color: favorite ? accentColor : null,
          ),
          onPressed: () {
            const ArticleDetailFavorite().dispatch(context);
          },
        );
      },
    );
  }
}

class _ListLoading extends StatelessWidget {
  const _ListLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
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
          children: <Widget>[
            const Text("powered by"),
            const SizedBox(width: 4.0),
            Image.network(
              "https://connpass.com/static/img/api/connpass_logo_1.png",
              fit: BoxFit.contain,
              width: 125,
              height: 42,
            ),
          ],
        ),
      ),
    );
  }
}
