import 'dart:io';

import 'package:employee_info/api/api_base.dart';
import 'package:employee_info/model/employee_details_response_model.dart';
import 'package:employee_info/model/employee_response_model.dart';
import 'package:employee_info/screen/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmployeeProvider extends ChangeNotifier {
  bool isAuthenticated = false;

  Future<List<EmployeeResponseModel>?> getAllEmployee() async {
    try {
      http.Response response = await http.get(
        Uri.parse(ApiBaseUrl().employeeBaseUrl),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = response.body;
        notifyListeners();
        return employeeResponseModelFromJson(jsonData);
      } else {
        throw Exception(AppStrings.failedToLoadEmployeeList);
      }
    } on SocketException {
      throw AppStrings.noInternet;
    }
  }

  Future<EmployeeDetailsResponseModel> getEmployeeDetailsById(var id) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${ApiBaseUrl().empDetailsBaseUrl}?id=$id'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        var responseData = response.body;
        notifyListeners();
        return employeeDetailsResponseModelFromJson(responseData);
      } else {
        throw Exception(AppStrings.failedToLoadEmployeeList);
      }
    } on SocketException {
      throw AppStrings.noInternet;
    }
  }
}
