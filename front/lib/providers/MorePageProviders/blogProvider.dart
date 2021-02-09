import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../Setting/serverUrl.dart';

class BlogProvider with ChangeNotifier {
  List<Map<String, Object>> _blogs;

  List<Map<String, Object>> get blogs {
    return [..._blogs];
  }

  Future<void> fetchBlog() async {
    _blogs = [];
    final url = blogApiUrl;
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      if (responseData == null) return;
      responseData.forEach((element) {
        _blogs.add({
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
