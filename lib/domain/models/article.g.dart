// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    json['event_id'] as int,
    json['title'] as String,
    json['catch'] as String,
    json['description'] as String,
    json['place'] as String,
    json['address'] as String,
    json['event_url'] as String,
    json['started_at'] == null
        ? null
        : DateTime.parse(json['started_at'] as String),
    json['end_at'] == null ? null : DateTime.parse(json['end_at'] as String),
    json['limit'] as int,
    json['accepted'] as int,
    json['waiting'] as int,
  );
}

ArticleList _$ArticleListFromJson(Map<String, dynamic> json) {
  return ArticleList(
    json['results_start'] as int,
    json['results_returned'] as int,
    json['results_available'] as int,
    (json['events'] as List)
        ?.map((e) =>
            e == null ? null : Article.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
