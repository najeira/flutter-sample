import '../imports.dart';

abstract class ArticleDetailState {
  const ArticleDetailState(this.data);

  final Article data;
}

class ArticleDetailInital extends ArticleDetailState {
  const ArticleDetailInital(Article data) : super(data);
}

class ArticleDetailLoadProgress extends ArticleDetailState {
  const ArticleDetailLoadProgress(Article data) : super(data);
}

class ArticleDetailLoadSuccess extends ArticleDetailState {
  const ArticleDetailLoadSuccess(Article data) : super(data);
}
