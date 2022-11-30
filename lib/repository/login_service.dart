import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';

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

      FirebaseCrashlytics.instance.setUserIdentifier(email);

      msg = data['message'];

      SharedPreferences localStorage = await SharedPreferences.getInstance();

      if (data['status'] as int == 0) {
        localStorage.setString('user', jsonEncode(data['result']['user']));
        localStorage.setString('address', '');
      }

      return response.body;
    } else {
      is_loading = false;
      throw Exception('Failed to login.');
    }

  }

  Future<String> register(String username, String email, String password, String passConfirm) async {

    is_loading = true;

    final response = await http.post(Uri.parse(Constant.register), body: {
      'username': username,
      'email': email,
      'password': password,
      'pass_confirm': passConfirm,
    });

    var data = jsonDecode(response.body);
    print(data);

    if (response.statusCode == 200) {

      return response.body;
    } else {
      is_loading = false;
      throw Exception('Failed to register.');
    }

  }

  Future<String> resendactivation(String login) async {

    is_loading = true;

    // await Future.delayed(const Duration(seconds: 5), () {
    //   print("Future.delayed");
    // });

    final response = await http.post(Uri.parse(Constant.apiresendactivation), body: {
      'login': login,
    });

    is_loading = false;

    var data = jsonDecode(response.body);
    print(data);

    if (response.statusCode == 200) {


      return data['message'];
    } else {
      is_loading = false;
      throw Exception('Failed to login.');
    }

  }

}