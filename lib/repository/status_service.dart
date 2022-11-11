import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/address_model.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/company_model.dart';
import 'package:siapprint/model/status_model.dart';
import 'package:siapprint/model/transaction_model.dart';
import 'package:siapprint/model/user_model.dart';

class StatusService {

  bool is_loading = false;

  Future<List<StatusModel>> getListStatus(String statuscode) async {

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    if(statuscode.contains('Sedang berjalan')) {
      statuscode = jsonEncode(['PST001', 'PST002', 'PST003', 'PST004', 'PST005']);
    } else {
      statuscode = jsonEncode(['PST000','PST006']);
    }

    final response = await http.post(Uri.parse(Constant.apilisttransaction), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id,
      'statuscode': statuscode,
    });

    if (response.statusCode == 200) {

      is_loading = false;

      final data = jsonDecode(response.body);

      var list = data['result']['trsc_print_h'] as List;
      var listData = list.map((data) => StatusModel.fromJson2(data) ).toList();

      return listData;
    } else {
      is_loading = false;
      throw Exception('Failed to get status list.');
    }

  }

}