import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_sample/app/blocs/blocs.dart';
import 'package:flutter_sample/app/helpers/datetime.dart';

import 'package:flutter_sample/domain/domain.dart';

import 'article_detail.dart';

class ArticleListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter勉強会"),
      ),
      body: ArticleListView.bloc(),
    );
  }
}

class ArticleListView extends StatelessWidget {
  const ArticleListView();

  static Widget bloc() {
    return BlocProvider<ArticleListBloc>(
      create: (BuildContext context) => ArticleListBloc()..add(const ArticleListStart()),
      child: const ArticleListView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleListBloc, ArticleListState>(
      builder: (BuildContext context, ArticleListState state) {
        debugPrint("ArticleListView ${state?.data?.count}");
        final bool loading = state is ArticleListLoadProgress || state is ArticleListInital;
        final bool hasNext = state is! ArticleListLoadFinish;
        final int count = state.data?.articles?.length ?? 0;
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
                BlocProvider.of<ArticleListBloc>(context)?.add(const ArticleListNext());
              }

              return const _ListTail();
            } else if (index > count) {
              // itemCountを指定しているのでここには来ないはず
              return null;
            }

            return ArticleListTile.bloc(state.data.articles[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        );
      },
    );
  }
}

class ArticleListTile extends StatelessWidget {
  const ArticleListTile();

  static Widget bloc(Article article) {
    assert(article != null);
    return BlocProvider<ArticleDetailBloc>(
      create: (BuildContext context) => ArticleDetailBloc(article),
      child: const ArticleListTile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Theme.of(context).accentColor;
    return BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
      builder: (BuildContext context, ArticleDetailState state) {
        final Article article = state.data;
        debugPrint("ArticleListTile ${article?.id}");
        return ListTile(
          title: Hero(
            tag: "article-title-${article.id}",
            child: Material(
              child: Text(article.title),
            ),
          ),
          subtitle: Text(formatDateTime(article.startAt)),
          trailing: Icon(
            article.favorite ? Icons.favorite : Icons.favorite_border,
            color: article.favorite ? accentColor : null,
          ),
          onTap: () {
            ArticleDetailPage.push(context, article);
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
