import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/company_model.dart';
import 'package:siapprint/model/user_model.dart';

class DeliveryService {

  bool is_loading = false;

  Future<http.Response> getDelivery() async {

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    final response = await http.post(Uri.parse(Constant.apijne), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id,
      'delv_code':'DLV002',
      'provinces_id_from':'9',
      'regencies_id_from':'23',
      'provinces_id_to':'9',
      'regencies_id_to':'23',
      'total_weigth':'0.009',
    });

    if (response.statusCode == 200) {

      is_loading = false;

      return response;
    } else {
      is_loading = false;
      throw Exception('Failed to get basket.');
    }

  }

}