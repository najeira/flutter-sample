// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ArticleSource _$ArticleSourceFromJson(Map<String, dynamic> json) {
  return _ArticleSource.fromJson(json);
}

class _$ArticleSourceTearOff {
  const _$ArticleSourceTearOff();

// ignore: unused_element
  _ArticleSource call({String id, @required String name}) {
    return _ArticleSource(
      id: id,
      name: name,
    );
  }
}

// ignore: unused_element
const $ArticleSource = _$ArticleSourceTearOff();

mixin _$ArticleSource {
  String get id;
  String get name;

  Map<String, dynamic> toJson();
  $ArticleSourceCopyWith<ArticleSource> get copyWith;
}

abstract class $ArticleSourceCopyWith<$Res> {
  factory $ArticleSourceCopyWith(
          ArticleSource value, $Res Function(ArticleSource) then) =
      _$ArticleSourceCopyWithImpl<$Res>;
  $Res call({String id, String name});
}

class _$ArticleSourceCopyWithImpl<$Res>
    implements $ArticleSourceCopyWith<$Res> {
  _$ArticleSourceCopyWithImpl(this._value, this._then);

  final ArticleSource _value;
  // ignore: unused_field
  final $Res Function(ArticleSource) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
    ));
  }
}

abstract class _$ArticleSourceCopyWith<$Res>
    implements $ArticleSourceCopyWith<$Res> {
  factory _$ArticleSourceCopyWith(
          _ArticleSource value, $Res Function(_ArticleSource) then) =
      __$ArticleSourceCopyWithImpl<$Res>;
  @override
  $Res call({String id, String name});
}

class __$ArticleSourceCopyWithImpl<$Res>
    extends _$ArticleSourceCopyWithImpl<$Res>
    implements _$ArticleSourceCopyWith<$Res> {
  __$ArticleSourceCopyWithImpl(
      _ArticleSource _value, $Res Function(_ArticleSource) _then)
      : super(_value, (v) => _then(v as _ArticleSource));

  @override
  _ArticleSource get _value => super._value as _ArticleSource;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
  }) {
    return _then(_ArticleSource(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
    ));
  }
}

@JsonSerializable()
class _$_ArticleSource with DiagnosticableTreeMixin implements _ArticleSource {
  const _$_ArticleSource({this.id, @required this.name}) : assert(name != null);

  factory _$_ArticleSource.fromJson(Map<String, dynamic> json) =>
      _$_$_ArticleSourceFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ArticleSource(id: $id, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ArticleSource'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ArticleSource &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name);

  @override
  _$ArticleSourceCopyWith<_ArticleSource> get copyWith =>
      __$ArticleSourceCopyWithImpl<_ArticleSource>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ArticleSourceToJson(this);
  }
}

abstract class _ArticleSource implements ArticleSource {
  const factory _ArticleSource({String id, @required String name}) =
      _$_ArticleSource;

  factory _ArticleSource.fromJson(Map<String, dynamic> json) =
      _$_ArticleSource.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  _$ArticleSourceCopyWith<_ArticleSource> get copyWith;
}

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return _Article.fromJson(json);
}

class _$ArticleTearOff {
  const _$ArticleTearOff();

// ignore: unused_element
  _Article call(
      {ArticleSource source,
      @required String title,
      String description,
      String author,
      @required String url,
      String urlToImage,
      String publishedAt,
      String content}) {
    return _Article(
      source: source,
      title: title,
      description: description,
      author: author,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }
}

// ignore: unused_element
const $Article = _$ArticleTearOff();

mixin _$Article {
  ArticleSource get source;
  String get title;
  String get description;
  String get author;
  String get url;
  String get urlToImage;
  String get publishedAt;
  String get content;

  Map<String, dynamic> toJson();
  $ArticleCopyWith<Article> get copyWith;
}

abstract class $ArticleCopyWith<$Res> {
  factory $ArticleCopyWith(Article value, $Res Function(Article) then) =
      _$ArticleCopyWithImpl<$Res>;
  $Res call(
      {ArticleSource source,
      String title,
      String description,
      String author,
      String url,
      String urlToImage,
      String publishedAt,
      String content});

  $ArticleSourceCopyWith<$Res> get source;
}

class _$ArticleCopyWithImpl<$Res> implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._value, this._then);

  final Article _value;
  // ignore: unused_field
  final $Res Function(Article) _then;

  @override
  $Res call({
    Object source = freezed,
    Object title = freezed,
    Object description = freezed,
    Object author = freezed,
    Object url = freezed,
    Object urlToImage = freezed,
    Object publishedAt = freezed,
    Object content = freezed,
  }) {
    return _then(_value.copyWith(
      source: source == freezed ? _value.source : source as ArticleSource,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      author: author == freezed ? _value.author : author as String,
      url: url == freezed ? _value.url : url as String,
      urlToImage:
          urlToImage == freezed ? _value.urlToImage : urlToImage as String,
      publishedAt:
          publishedAt == freezed ? _value.publishedAt : publishedAt as String,
      content: content == freezed ? _value.content : content as String,
    ));
  }

  @override
  $ArticleSourceCopyWith<$Res> get source {
    if (_value.source == null) {
      return null;
    }
    return $ArticleSourceCopyWith<$Res>(_value.source, (value) {
      return _then(_value.copyWith(source: value));
    });
  }
}

abstract class _$ArticleCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$ArticleCopyWith(_Article value, $Res Function(_Article) then) =
      __$ArticleCopyWithImpl<$Res>;
  @override
  $Res call(
      {ArticleSource source,
      String title,
      String description,
      String author,
      String url,
      String urlToImage,
      String publishedAt,
      String content});

  @override
  $ArticleSourceCopyWith<$Res> get source;
}

class __$ArticleCopyWithImpl<$Res> extends _$ArticleCopyWithImpl<$Res>
    implements _$ArticleCopyWith<$Res> {
  __$ArticleCopyWithImpl(_Article _value, $Res Function(_Article) _then)
      : super(_value, (v) => _then(v as _Article));

  @override
  _Article get _value => super._value as _Article;

  @override
  $Res call({
    Object source = freezed,
    Object title = freezed,
    Object description = freezed,
    Object author = freezed,
    Object url = freezed,
    Object urlToImage = freezed,
    Object publishedAt = freezed,
    Object content = freezed,
  }) {
    return _then(_Article(
      source: source == freezed ? _value.source : source as ArticleSource,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      author: author == freezed ? _value.author : author as String,
      url: url == freezed ? _value.url : url as String,
      urlToImage:
          urlToImage == freezed ? _value.urlToImage : urlToImage as String,
      publishedAt:
          publishedAt == freezed ? _value.publishedAt : publishedAt as String,
      content: content == freezed ? _value.content : content as String,
    ));
  }
}

@JsonSerializable()
class _$_Article with DiagnosticableTreeMixin implements _Article {
  const _$_Article(
      {this.source,
      @required this.title,
      this.description,
      this.author,
      @required this.url,
      this.urlToImage,
      this.publishedAt,
      this.content})
      : assert(title != null),
        assert(url != null);

  factory _$_Article.fromJson(Map<String, dynamic> json) =>
      _$_$_ArticleFromJson(json);

  @override
  final ArticleSource source;
  @override
  final String title;
  @override
  final String description;
  @override
  final String author;
  @override
  final String url;
  @override
  final String urlToImage;
  @override
  final String publishedAt;
  @override
  final String content;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Article(source: $source, title: $title, description: $description, author: $author, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Article'))
      ..add(DiagnosticsProperty('source', source))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('urlToImage', urlToImage))
      ..add(DiagnosticsProperty('publishedAt', publishedAt))
      ..add(DiagnosticsProperty('content', content));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Article &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.urlToImage, urlToImage) ||
                const DeepCollectionEquality()
                    .equals(other.urlToImage, urlToImage)) &&
            (identical(other.publishedAt, publishedAt) ||
                const DeepCollectionEquality()
                    .equals(other.publishedAt, publishedAt)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality().equals(other.content, content)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(source) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(urlToImage) ^
      const DeepCollectionEquality().hash(publishedAt) ^
      const DeepCollectionEquality().hash(content);

  @override
  _$ArticleCopyWith<_Article> get copyWith =>
      __$ArticleCopyWithImpl<_Article>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ArticleToJson(this);
  }
}

abstract class _Article implements Article {
  const factory _Article(
      {ArticleSource source,
      @required String title,
      String description,
      String author,
      @required String url,
      String urlToImage,
      String publishedAt,
      String content}) = _$_Article;

  factory _Article.fromJson(Map<String, dynamic> json) = _$_Article.fromJson;

  @override
  ArticleSource get source;
  @override
  String get title;
  @override
  String get description;
  @override
  String get author;
  @override
  String get url;
  @override
  String get urlToImage;
  @override
  String get publishedAt;
  @override
  String get content;
  @override
  _$ArticleCopyWith<_Article> get copyWith;
}

ArticleList _$ArticleListFromJson(Map<String, dynamic> json) {
  return _ArticleList.fromJson(json);
}

class _$ArticleListTearOff {
  const _$ArticleListTearOff();

// ignore: unused_element
  _ArticleList call(List<Article> articles) {
    return _ArticleList(
      articles,
    );
  }
}

// ignore: unused_element
const $ArticleList = _$ArticleListTearOff();

mixin _$ArticleList {
  List<Article> get articles;

  Map<String, dynamic> toJson();
  $ArticleListCopyWith<ArticleList> get copyWith;
}

abstract class $ArticleListCopyWith<$Res> {
  factory $ArticleListCopyWith(
          ArticleList value, $Res Function(ArticleList) then) =
      _$ArticleListCopyWithImpl<$Res>;
  $Res call({List<Article> articles});
}

class _$ArticleListCopyWithImpl<$Res> implements $ArticleListCopyWith<$Res> {
  _$ArticleListCopyWithImpl(this._value, this._then);

  final ArticleList _value;
  // ignore: unused_field
  final $Res Function(ArticleList) _then;

  @override
  $Res call({
    Object articles = freezed,
  }) {
    return _then(_value.copyWith(
      articles:
          articles == freezed ? _value.articles : articles as List<Article>,
    ));
  }
}

abstract class _$ArticleListCopyWith<$Res>
    implements $ArticleListCopyWith<$Res> {
  factory _$ArticleListCopyWith(
          _ArticleList value, $Res Function(_ArticleList) then) =
      __$ArticleListCopyWithImpl<$Res>;
  @override
  $Res call({List<Article> articles});
}

class __$ArticleListCopyWithImpl<$Res> extends _$ArticleListCopyWithImpl<$Res>
    implements _$ArticleListCopyWith<$Res> {
  __$ArticleListCopyWithImpl(
      _ArticleList _value, $Res Function(_ArticleList) _then)
      : super(_value, (v) => _then(v as _ArticleList));

  @override
  _ArticleList get _value => super._value as _ArticleList;

  @override
  $Res call({
    Object articles = freezed,
  }) {
    return _then(_ArticleList(
      articles == freezed ? _value.articles : articles as List<Article>,
    ));
  }
}

@JsonSerializable()
class _$_ArticleList with DiagnosticableTreeMixin implements _ArticleList {
  const _$_ArticleList(this.articles) : assert(articles != null);

  factory _$_ArticleList.fromJson(Map<String, dynamic> json) =>
      _$_$_ArticleListFromJson(json);

  @override
  final List<Article> articles;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ArticleList(articles: $articles)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ArticleList'))
      ..add(DiagnosticsProperty('articles', articles));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ArticleList &&
            (identical(other.articles, articles) ||
                const DeepCollectionEquality()
                    .equals(other.articles, articles)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(articles);

  @override
  _$ArticleListCopyWith<_ArticleList> get copyWith =>
      __$ArticleListCopyWithImpl<_ArticleList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ArticleListToJson(this);
  }
}

abstract class _ArticleList implements ArticleList {
  const factory _ArticleList(List<Article> articles) = _$_ArticleList;

  factory _ArticleList.fromJson(Map<String, dynamic> json) =
      _$_ArticleList.fromJson;

  @override
  List<Article> get articles;
  @override
  _$ArticleListCopyWith<_ArticleList> get copyWith;
}
