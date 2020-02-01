import '_imports.dart';

class ArticleService {
  const ArticleService();

  Future<ArticleList> articleList([ArticleList before]) async {
    // 末尾まで到達していたら何もしない
    if (before != null) {
      if (before.count >= before.total) {
        logger.info("finish ${before.count} >= ${before.total}");
        return null;
      }
    }

    // ローディングの表示を分かりやすくするためdelayを入れておく
    await Future<void>.delayed(const Duration(seconds: 1));

    // 次のリストを読み込む
    final RemoteRepository repository = getIt<RemoteRepository>();
    return repository.articleList(before);
  }
}
