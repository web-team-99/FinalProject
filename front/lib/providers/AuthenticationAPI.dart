import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test_url/Setting/serverUrl.dart';
import 'package:test_url/models/user.dart';

class AuthenticationAPI {
  Future<User> sendSignUpRequest(User user) async {
    var response;
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    // String body =
    //     "name=${user.name}&lname=${user.lastName}&password=${user.password}&email=${user.email}&phone=${user.phone}";
    String body =
        "name=mohammad&lname=mir&password=789&email=mohammad123@gmail.com&phone=0915854654";
    try {
      response = await http.post(signupUrl, headers: headers, body: body);
      if (response.statusCode >= 400) {
        // throw HttpException("Bad Connection");
        print(response.statusCode);
      }
      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (responseData == null) return null;
      final userData = responseData['user'] as Map<String, dynamic>;

      final resUser = User(
        id: userData['_id'],
        name: userData['name'],
        lastName: userData['lname'],
        email: userData['email'],
        phone: userData['phone'],
        score: userData['Score'],
        freelanceNo: userData['FreelanceNo'],
        projectNo: userData['ProjectNo'],
      );
      return resUser;
    } catch (e) {
      throw (e);
    }
  }

  Future<User> sendLoginRequest(String email, String password) async {
    var response;
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    String body = "password=$password&email=$email";
    try {
      response = http.post(loginUrl, headers: headers, body: body);
      if (response.statusCode >= 400) {
        throw HttpException("Bad Connection");
      }
      final responseData =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (responseData == null) return null;
      final userData = responseData['user'] as Map<String, dynamic>;

      final resUser = User(
        id: userData['_id'],
        name: userData['name'],
        lastName: userData['lname'],
        email: userData['email'],
        phone: userData['phone'],
        score: userData['Score'],
        freelanceNo: userData['FreelanceNo'],
        projectNo: userData['ProjectNo'],
      );
      return resUser;
    } catch (e) {
      throw (e);
    }
  }
}
