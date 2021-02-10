import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../Setting/serverUrl.dart';

class BlogPostProvider with ChangeNotifier {
  bool _isLoading = true;
  List<Map<String, Object>> _blogPost;

  List<Map<String, Object>> get blogPost {
    return [..._blogPost];
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<void> fetchBlogPost(int id) async {
    _blogPost = [];
    _isLoading = true;
    final url = "$blogApiUrl/${id}";
    try {
      final response = await http.get(url);
      _isLoading = false;
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      if (responseData == null) return;
      responseData.forEach((element) {
        _blogPost.add({
          'id': element['id'],
          'content': element['content'],
          'title': element['title'],
          'update_time': element['update_time'],
          'create_time': element['create_time'],
          'image': element['image'],
          'owner': element['owner'],
        });
      });
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
