import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/user_model.dart';

class LoginService {

  final Dio _dio = Dio();

  Future<http.Response> login(String email, String password) async {
    final response = await http.post(Uri.parse(Constant.login), body: {
      'login': email,
      'password': password
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      // SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString('user', json['result']['user']);

      return response;
      // return UserModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to login.');
    }

  }

}