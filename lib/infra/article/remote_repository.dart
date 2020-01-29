import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_sample/domain/models/article.dart';

class RemoteRepository {
  RemoteRepository(
    this.host,
    this.path,
  );

  final String host;

  final String path;

  Future<ArticleList> articleList() async {
    final Uri uri = Uri.https(
      host,
      path,
      <String, String>{
        "keyword": "Flutter",
      },
    );
    final http.Response resp = await http.get(uri);
    final dynamic data = json.decode(resp.body);
    final ArticleList result = ArticleList.fromJson(data as Map<String, dynamic>);
    return result;
  }
}
