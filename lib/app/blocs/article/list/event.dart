abstract class ArticleListEvent {
  const ArticleListEvent();
}

class ArticleListStart extends ArticleListEvent {
  const ArticleListStart();
}

class ArticleListNext extends ArticleListEvent {
  const ArticleListNext();
}
