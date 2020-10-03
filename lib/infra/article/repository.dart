import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_sample/domain/models/article.dart';
import 'package:flutter_sample/helpers/logger.dart';

class RemoteRepository {
  const RemoteRepository();

  Future<ArticleList> articleList() async {
    final Uri uri = Uri.https(
      "newsapi.org",
      "/v2/top-headlines",
      <String, String>{
        "country": "jp",
        "apiKey": "250092088c2447f69a872c7f0d4e1709",
        "pageSize": "100",
      },
    );
    logger.info(uri.toString());

    final http.Response resp = await http.get(uri);

    final dynamic data = json.decode(resp.body);
    final ArticleList result = ArticleList.fromJson(data as Map<String, dynamic>);
    return result;
  }
}
