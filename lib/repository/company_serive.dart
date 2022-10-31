import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/company_model.dart';
import 'package:siapprint/model/user_model.dart';

class CompanyService {

  List<CompanyModel> listCompany = [];

  bool is_loading = false;

  Future<http.Response> getCompany() async {

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    final response = await http.post(Uri.parse(Constant.company_detail), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id
    });

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      var dataListCompany = data['result']['company_selected'] as List;

      listCompany = dataListCompany.map((data) => CompanyModel.fromJson2(data) ).toList();

      is_loading = false;

      return response;
    } else {
      is_loading = false;
      throw Exception('Failed to get basket.');
    }

  }

}