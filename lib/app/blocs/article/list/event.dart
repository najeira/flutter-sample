import 'package:flutter/material.dart';

abstract class ArticleListEvent extends Notification {
  const ArticleListEvent();
}

class ArticleListStart extends ArticleListEvent {
  const ArticleListStart();
}

class ArticleListNext extends ArticleListEvent {
  const ArticleListNext();
}
