import 'dart:io';

import 'package:http/http.dart' as http;

class AuthenticationAPI {
  String loginURL = "";

  Future<String> sendSignUpRequest() async {
    dynamic response = 'This is the reposne from server';
    // try {
    //   response = await http.get(loginURL);
    //   if (response.statusCode >= 400) {
    //     throw HttpException("Bad Connection");
    //   }
    // } catch (e) {} finally {

    // }
    print('sending signup .........');
    await Future.delayed(Duration(seconds: 10));
    return Future.value(response);
  }

  Future<String> sendLoginRequest() async {

  }

  sendLogoutRequest() {

  }

  
}
