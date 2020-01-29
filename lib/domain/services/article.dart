import 'package:flutter/material.dart' show debugPrint;

import 'package:get_it/get_it.dart';

import 'package:flutter_sample/domain/models/article.dart';
import 'package:flutter_sample/infra/infra.dart';

class ArticleService {
  const ArticleService();

  Future<ArticleList> articleList([ArticleList before]) async {
    // 末尾まで到達していたら何もしない
    if (before != null) {
      if (before.count >= before.total) {
        debugPrint("finish ${before.count} >= ${before.total}");
        return null;
      }
    }

    // ローディングの表示を分かりやすくするためdelayを入れておく
    await Future<void>.delayed(const Duration(seconds: 1));

    // 次のリストを読み込む
    final RemoteRepository repository = GetIt.instance.get<RemoteRepository>();
    return repository.articleList(before);
  }
}
