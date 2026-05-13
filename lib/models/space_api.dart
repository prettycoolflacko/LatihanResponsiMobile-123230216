import 'dart:convert';

import 'package:http/http.dart' as http;
import 'space_item.dart';

enum ContentType {
  news,
  blogs,
  reports,
}

extension ContentTypeX on ContentType {
  String get title {
    switch (this) {
      case ContentType.news:
        return 'Hot News';
      case ContentType.blogs:
        return 'Hot Blogs';
      case ContentType.reports:
        return 'Hot Reports';
    }
  }

  String get endpoint {
    switch (this) {
      case ContentType.news:
        return 'articles';
      case ContentType.blogs:
        return 'blogs';
      case ContentType.reports:
        return 'reports';
    }
  }
}

class SpaceApi {
  static const String _baseUrl = 'https://api.spaceflightnewsapi.net/v4';

  Future<List<SpaceItem>> fetchList(ContentType type) async {
    final Uri uri = Uri.parse('$_baseUrl/${type.endpoint}/');
    final http.Response response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load ${type.title} list');
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic> results = data['results'] as List<dynamic>? ?? [];
    return results
        .map((item) => SpaceItem.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  Future<SpaceItem> fetchDetail(ContentType type, int id) async {
    final Uri uri = Uri.parse('$_baseUrl/${type.endpoint}/$id/');
    final http.Response response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load ${type.title} detail');
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;
    return SpaceItem.fromMap(data);
  }
}
