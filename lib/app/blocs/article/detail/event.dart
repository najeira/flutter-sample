import '../../_imports.dart';

abstract class ArticleDetailEvent extends AppEvent {
  const ArticleDetailEvent();
}

class ArticleDetailStart extends ArticleDetailEvent {
  const ArticleDetailStart();
}

class ArticleDetailFavorite extends ArticleDetailEvent {
  const ArticleDetailFavorite();
}
