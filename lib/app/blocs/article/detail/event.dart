import 'package:flutter/material.dart';

abstract class ArticleDetailEvent extends Notification {
  const ArticleDetailEvent();
}

class ArticleDetailStart extends ArticleDetailEvent {
  const ArticleDetailStart();
}

class ArticleDetailFavorite extends ArticleDetailEvent {
  const ArticleDetailFavorite();
}
