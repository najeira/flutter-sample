import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable(createToJson: false)
class Article {
  Article(
    this.id,
    this.title,
    this.caption,
    this.description,
    this.place,
    this.address,
    this.url,
    this.startAt,
    this.endAt,
    this.limit,
    this.accepted,
    this.waiting,
  );

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  @JsonKey(name: 'event_id')
  final int id;

  final String title;

  @JsonKey(name: 'catch')
  final String caption;

  final String description;

  final String place;

  final String address;

  @JsonKey(name: 'event_url')
  final String url;

  @JsonKey(name: 'started_at')
  final DateTime startAt;

  @JsonKey(name: 'end_at')
  final DateTime endAt;

  final int limit;
  final int accepted;
  final int waiting;

  @JsonKey(ignore: true)
  bool favorite = false;
}

@JsonSerializable(createToJson: false)
class ArticleList {
  ArticleList(
    this.start,
    this.count,
    this.total,
    this.articles,
  );

  factory ArticleList.fromJson(Map<String, dynamic> json) => _$ArticleListFromJson(json);

  @JsonKey(name: 'results_start')
  final int start;

  @JsonKey(name: 'results_returned')
  final int count;

  @JsonKey(name: 'results_available')
  final int total;

  @JsonKey(name: 'events')
  final List<Article> articles;
}
