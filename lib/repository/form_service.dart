import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/inks_model.dart';
import 'package:siapprint/model/user_model.dart';

class FormService {

  bool is_loading = false;
  List<InkModel> listInkModel = [];

  Future<http.Response> getFieldFormPrint(String compid) async {

    is_loading = true;
    print('loading...');

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    final response = await http.post(Uri.parse(Constant.apiprint), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id,
      'compid': compid
    });

    is_loading = false;
    print('done...');

    // final response = await http.get(Uri.parse('https://mocki.io/v1/d4fbff64-c4b7-412c-b8b7-df0a099d549a'));

    if (response.statusCode == 200) {
      is_loading = false;
      var json = jsonDecode(response.body);

      return response;
    } else {
      is_loading = false;
      throw Exception('Failed to get field form.');
    }

  }

}