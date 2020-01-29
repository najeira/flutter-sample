import 'package:flutter_sample/domain/models/article.dart';

import 'package:flutter_sample/infra/infra.dart';

class ArticleService {
  ArticleService(this.repository);

  final RemoteRepository repository;

  Future<ArticleList> articleList() async {
    // ローディングの表示を分かりやすくするためdelayを入れておく
    await Future<void>.delayed(const Duration(seconds: 1));
    return repository.articleList();
  }
}
