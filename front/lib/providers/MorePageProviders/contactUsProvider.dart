import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../Setting/serverUrl.dart';

class ContactUsProvider with ChangeNotifier {
  List<Map<String, String>> _contactUs;

  List<Map<String, String>> get contactUs {
    return [..._contactUs];
  }

  Future<void> fetchContactUs() async {
    _contactUs = [];
    final url = contactUsApiUrl;
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      if (responseData == null) return;
      responseData.forEach((element) {
        _contactUs.add(
            {'question': element['title'], 'answer': element['description']});
      });
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
