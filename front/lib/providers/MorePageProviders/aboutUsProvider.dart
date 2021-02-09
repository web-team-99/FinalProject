import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../Setting/serverUrl.dart';

class AboutUsProvider with ChangeNotifier {
  List<Map<String, String>> _aboutUs;

  List<Map<String, String>> get aboutUs {
    return [..._aboutUs];
  }

  Future<void> fetchAboutUs() async {
    _aboutUs = [];
    final url = aboutUsApiUrl;
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }

      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      if (responseData == null) return;
      responseData.forEach((element) {
        _aboutUs.add({
          'question': element['question'],
          'answer': element['answer'],
        });
      });
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
