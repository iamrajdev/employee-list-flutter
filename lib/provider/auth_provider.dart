import 'dart:convert';

import 'package:employee_info/api/api_base.dart';
import 'package:employee_info/helper/login_status_enum.dart';
import 'package:employee_info/helper/utils.dart';
import 'package:employee_info/model/login_response_model.dart';
import 'package:employee_info/screen/resources/strings_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool isAuthenticated = false;

  LoginStatusEnum _loggedInStatus = LoginStatusEnum.NotLoggedIn;
  LoginStatusEnum _registeredInStatus = LoginStatusEnum.NotRegistered;

  LoginStatusEnum get loggedInStatus => _loggedInStatus;

  set loggedInStatus(LoginStatusEnum value) {
    _loggedInStatus = value;
    notifyListeners();
  }

  LoginStatusEnum get registeredInStatus => _registeredInStatus;
  set registeredInStatus(LoginStatusEnum value) {
    _registeredInStatus = value;
    notifyListeners();
  }

  Future<List<LoginResponseModel>?> login(String email, String password) async {
    isAuthenticated = true;
    _loggedInStatus = LoginStatusEnum.Authenticating;
    notifyListeners();

    try {
      http.Response response = await http.get(
        Uri.parse('${ApiBaseUrl().loginBaseUrl}'
            '?user_id=$email&password=$password'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        isAuthenticated = false;
        _loggedInStatus = LoginStatusEnum.LoggedIn;
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        await setString(AppStrings.email, parsed[0]['user_id']);
        await setString(AppStrings.password, parsed[0]['password']);
        notifyListeners();
        return parsed.map<LoginResponseModel>((json) {
          return LoginResponseModel.fromJson(json);
        }).toList();
      }
    } on Exception {
      isAuthenticated = false;
      return null;
    }
    return null;
  }

  Future<void> logOut() async {
    String email = '';
    String password = '';
    setString(AppStrings.email, email);
    setString(AppStrings.password, password);
    _loggedInStatus = LoginStatusEnum.NotLoggedIn;
    notifyListeners();
  }
}
