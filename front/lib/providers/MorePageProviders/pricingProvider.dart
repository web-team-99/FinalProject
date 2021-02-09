import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../Setting/serverUrl.dart';
import '../../models/ProviderModels/pricingsModel.dart';

class PricingProvider with ChangeNotifier {
  List<PricingModel> _pricings;

  List<PricingModel> get pricings {
    return [..._pricings];
  }

  Future<void> fetchPricings() async {
    _pricings = [];
    final url = pricingsApiUrl;
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw HttpException('Bad Connection');
      }
      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      if (responseData == null) return;
      responseData.forEach((element) {
        _pricings.add(PricingModel(
            id: element['id'],
            title: element['title'],
            description: element['description'],
            price: element['price']));
      });
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
