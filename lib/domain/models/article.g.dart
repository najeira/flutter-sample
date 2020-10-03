// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ArticleSource _$_$_ArticleSourceFromJson(Map<String, dynamic> json) {
  return _$_ArticleSource(
    id: json['id'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$_$_ArticleSourceToJson(_$_ArticleSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$_Article _$_$_ArticleFromJson(Map<String, dynamic> json) {
  return _$_Article(
    source: json['source'] == null
        ? null
        : ArticleSource.fromJson(json['source'] as Map<String, dynamic>),
    title: json['title'] as String,
    description: json['description'] as String,
    author: json['author'] as String,
    url: json['url'] as String,
    urlToImage: json['urlToImage'] as String,
    publishedAt: json['publishedAt'] as String,
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$_$_ArticleToJson(_$_Article instance) =>
    <String, dynamic>{
      'source': instance.source,
      'title': instance.title,
      'description': instance.description,
      'author': instance.author,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };

_$_ArticleList _$_$_ArticleListFromJson(Map<String, dynamic> json) {
  return _$_ArticleList(
    (json['articles'] as List)
        ?.map((e) =>
            e == null ? null : Article.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$_$_ArticleListToJson(_$_ArticleList instance) =>
    <String, dynamic>{
      'articles': instance.articles,
    };
