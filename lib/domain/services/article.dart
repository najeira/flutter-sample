import 'package:flutter_sample/domain/models/models.dart';
import 'package:flutter_sample/helpers/get_it.dart';
import 'package:flutter_sample/infra/infra.dart';

class ArticleService {
  const ArticleService();

  Future<ArticleList> articleList() async {
    // ローディングの表示を分かりやすくするためdelayを入れておく
    await Future<void>.delayed(const Duration(seconds: 1));

    // 次のリストを読み込む
    final RemoteRepository repository = getIt<RemoteRepository>();
    return repository.articleList();
  }
}
