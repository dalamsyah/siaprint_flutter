import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/user_model.dart';

class FormService {

  Future<http.Response> getFieldFormPrint(String compid) async {

    print("okeee");

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    final response = await http.post(Uri.parse(Constant.apiprint), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id,
      'compid': compid
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      return response;
    } else {
      throw Exception('Failed to get field form.');
    }

  }

}