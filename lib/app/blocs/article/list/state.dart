import '../../_imports.dart';

abstract class ArticleListState {
  const ArticleListState(this.data);

  final ArticleList data;
}

class ArticleListInital extends ArticleListState {
  const ArticleListInital() : super(null);
}

class ArticleListLoadProgress extends ArticleListState {
  const ArticleListLoadProgress(ArticleList data) : super(data);
}

class ArticleListLoadSuccess extends ArticleListState {
  const ArticleListLoadSuccess(ArticleList data) : super(data);
}

class ArticleListLoadFinish extends ArticleListState {
  const ArticleListLoadFinish(ArticleList data) : super(data);
}
