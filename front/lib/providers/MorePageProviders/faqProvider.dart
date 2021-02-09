import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../Setting/serverUrl.dart';

class FaqProvider with ChangeNotifier {
  List<Map<String, String>> _faq;

  List<Map<String, String>> get faq {
    return [..._faq];
  }

  Future<void> fetchFaq() async {
    _faq = [];
    final url = faqApiUrl;
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      if (responseData == null) return;
      responseData.forEach((element) {
        _faq.add({
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
