import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:test_url/Setting/serverUrl.dart';
import 'package:test_url/models/ProviderModels/ServiceModel.dart';

class ServicesProvider with ChangeNotifier {
  List<ServiceModel> _services;

  List<ServiceModel> get services {
    return [..._services];
  }

  Future<void> fetchProjects() async {
    _services = [];
    final url = servicesApiUrl;
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }

      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      if (responseData == null) return;
      responseData.forEach((element) {
        _services.add(ServiceModel(
            id: element['id'],
            authorId: element['authorId'],
            title: element['title'],
            shortDescription: element['shortDescription'],
            description: element['description'],
            price: element['price'],
            createdAt: element['createdAt']
            ));
      });
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
