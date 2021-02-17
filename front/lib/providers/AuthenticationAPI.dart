import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test_url/Setting/serverUrl.dart';
import 'package:test_url/models/user.dart';

class AuthenticationAPI {
  Future<String> sendSignUpRequest(User user) async {
    var response, data;
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    String body =
        "name=${user.name}&lname=${user.lastName}&password=${user.password}&email=${user.email}&phone=${user.phone}";
    try {
      response = await http.post(signupUrl, headers: headers, body: body);
      if (response.statusCode >= 400) {
        throw HttpException("Bad Connection");
      }
      data = response.toString();
      // data = json.decode(utf8.decode(response.bodyBytes));
      print(data);
    } catch (e) {
      print(e.toString());
    }

    // await Future.delayed(Duration(seconds: 10));
    return Future.value(data);
  }

  Future<String> sendLoginRequest(String email, String password) async {
    var response, data;
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    String body = "password=$password&email=$email";
    try {
      response = http.post(loginUrl, headers: headers, body: body);
    } catch (e) {}
    return Future.value(data);
  }

}
