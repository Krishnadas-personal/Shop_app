import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime exp_date;
  String userid;

  Future<void> _authenticate(
      String email, String password, String urlArg) async {
    try {
      final url =
          "https://identitytoolkit.googleapis.com/v1/accounts:$urlArg?key=AIzaSyA_ljkLIPuD0-QzrJ-YoKY0OusBv2yFqxM";

      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (err) {
      throw err;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    print("ALREADY EXITS");
    return _authenticate(email, password, 'signInWithPassword');
  }
}
