import '../../_imports.dart';

abstract class ArticleDetailEvent {
  const ArticleDetailEvent();
}

class ArticleDetailStart extends ArticleDetailEvent {
  const ArticleDetailStart();
}

class ArticleDetailUpdate extends ArticleDetailEvent {
  const ArticleDetailUpdate(this.data);

  final Article data;
}

class ArticleDetailFavorite extends ArticleDetailEvent {
  const ArticleDetailFavorite();
}
