import 'dart:convert';

import 'package:flutter/material.dart' show debugPrint;

import 'package:http/http.dart' as http;

import 'package:flutter_sample/domain/models/article.dart';

class RemoteRepository {
  const RemoteRepository(
    this.host,
    this.path,
  );

  final String host;

  final String path;

  Future<ArticleList> articleList([ArticleList before]) async {
    final int start = (before != null) ? (before.start + before.count) : 1;
    final Uri uri = Uri.https(
      host,
      path,
      <String, String>{
        "keyword": "Flutter",
        "start": start.toString(),
        "count": "20",
      },
    );
    debugPrint("${uri}");

    final http.Response resp = await http.get(uri);

    final dynamic data = json.decode(resp.body);
    final ArticleList result = ArticleList.fromJson(data as Map<String, dynamic>);
    return result;
  }
}
