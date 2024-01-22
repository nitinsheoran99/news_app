import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_info_model.dart';
import 'package:news_app/util/api_end_point.dart';
import 'package:news_app/util/app_constant.dart';

class NewsService {
  static Future<List<Articles>> fetchNews({
    required int pageKey,
    required String query,
  }) async {
    if (kDebugMode) {
      print('FetchingNews category=$query');
    }
    const int pageSize = 20;
    final url = Endpoints.getNewsByPaginationUrl(
      apiKey: AppConstant.apiKey,
      query: query,
      sortBy: 'publishedAt',
      page: pageKey,
      pageSize: pageSize,
    );

    final response = await http.get(Uri.parse(url));
    Map<String, dynamic> map = jsonDecode(response.body);
    if (response.statusCode == 200) {
      NewsInfo newsInfo = NewsInfo.fromJson(map);
      final List<Articles> articles = newsInfo.articles ?? [];
      return articles;
    } else {
      if (map['message'] != null) {
        throw map['message'];
      }
    }
    throw "Something went wrong";
  }
}