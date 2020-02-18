import '../../_imports.dart';

abstract class ArticleListEvent extends AppEvent {
  const ArticleListEvent();
}

class ArticleListStart extends ArticleListEvent {
  const ArticleListStart();
}

class ArticleListNext extends ArticleListEvent {
  const ArticleListNext();
}
