import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/user_model.dart';

class LoginService {

  final Dio _dio = Dio();
  bool is_loading = false;
  String msg = '';

  Future<String> login(String email, String password) async {

    is_loading = true;

    final response = await http.post(Uri.parse(Constant.login), body: {
      'login': email,
      'password': password
    });

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {

      msg = data['message'];

      SharedPreferences localStorage = await SharedPreferences.getInstance();

      if (data['status'] as int == 0) {
        localStorage.setString('user', jsonEncode(data['result']['user']));
      }

      // if (response.statusCode == 200) {
      //
      //   if (data['status'] as int == 0) {
      //     localStorage.setString('user', jsonEncode(data['result']['user']));
      //
      //     Navigator.of(context).pushNamedAndRemoveUntil(SingleNavigationPage.tag, (route) => false);
      //   } else {
      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //   }
      //
      // } else {
      //
      //   if (!mounted) return;
      //
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // }

      return response.body;
    } else {
      // is_loading = false;
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to login.');
    }

  }

}