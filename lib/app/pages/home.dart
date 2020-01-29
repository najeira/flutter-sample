import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:flutter_sample/app/blocs/blocs.dart';
import 'package:flutter_sample/domain/domain.dart';

class ArticleListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArticleListBloc>(
      create: (BuildContext context) => ArticleListBloc()..add(const ArticleListStart()),
      child: const ArticleListView(),
    );
  }
}

class ArticleListView extends StatelessWidget {
  const ArticleListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter勉強会"),
      ),
      body: BlocBuilder<ArticleListBloc, ArticleListState>(
        builder: (BuildContext context, ArticleListState state) {
          final bool loading = state is ArticleListLoadProgress;
          final int count = state.data?.articles?.length ?? 0;
          return ListView.separated(
            itemCount: count + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == count) {
                if (loading) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text("powered by Connpass"),
                  ),
                );
              } else if (index > count) {
                return null;
              }
              return Provider<Article>.value(
                value: state.data.articles[index],
                child: const ArticleListTile(),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}

class ArticleListTile extends StatelessWidget {
  const ArticleListTile();

  @override
  Widget build(BuildContext context) {
    return Consumer<Article>(
      builder: (BuildContext context, Article article, Widget child) {
        return ListTile(
          title: Text(article.title),
          subtitle: Text(article.caption ?? ''),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 14.0,
          ),
          onTap: () {
            // ArticleDetailPage.push(context, article);
          },
        );
      },
    );
  }
}
