import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
abstract class ArticleSource with _$ArticleSource {
  const factory ArticleSource({
    String id,
    @required String name,
  }) = _ArticleSource;

  factory ArticleSource.fromJson(Map<String, dynamic> json) => _$ArticleSourceFromJson(json);
}

@freezed
abstract class Article with _$Article {
  const factory Article({
    ArticleSource source,
    @required String title,
    String description,
    String author,
    @required String url,
    String urlToImage,
    String publishedAt,
    String content,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}

@freezed
abstract class ArticleList with _$ArticleList {
  const factory ArticleList(List<Article> articles) = _ArticleList;

  factory ArticleList.fromJson(Map<String, dynamic> json) => _$ArticleListFromJson(json);
}
