import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/address_model.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/company_model.dart';
import 'package:siapprint/model/transaction_model.dart';
import 'package:siapprint/model/user_model.dart';

class DeliveryService {

  bool is_loading = false;

  Future<http.Response> saveTransaction(TransactionModel transactionModel) async {

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    AddressModel addressModel = AddressModel.fromJson(userModel.address);

    Map<String, dynamic> map = {};
    map['fn_addr_default_regencies_id'] = addressModel.regencies_id;
    map['fn_addr_default_provinces_id'] = addressModel.province_id;
    map['fn_addr_default_address'] = addressModel.address;
    map['fn_addr_default_regencies_name'] = addressModel.regency_name;
    map['fn_addr_default_provinces_name'] = addressModel.province_name;
    map['fn_addr_default_postcode'] = addressModel.postcode;
    map['fn_addr_default_phone'] = addressModel.phone;
    map['fn_addr_default_receiver'] = addressModel.receiver;
    // map[''] = '';

    transactionModel.listBasketModel.asMap().forEach((i, value) {

      map['check_ink_$i'] = value.printer_code;
      map['id_papper_$i'] = value.ukuranKertas;
      map['type_paper_$i'] = value.jenisKertas;
      map['pages_$i'] = value.pages;
      map['count_print_$i'] = value.copyPage;
      map['finishing_$i'] = value.finishing;
      map['remarks_$i'] = value.notes;
      map['fn_temp_$i'] = "289";
      map['fn_filename_$i'] = value.filename;
      map['fn_filename_random_$i'] = value.filename_random;
      map['fn_size_code_$i'] = value.ukuranKertas;
      map['fn_ink_code_$i'] = value.printer_code;
      map['fn_type_paper_code_$i'] = value.jenisKertas;
      map['fn_copy_$i'] = value.copyPage;
      map['fn_finish_code_$i'] = value.finishing;
      map['fn_pages_$i'] = value.pages;
      map['fn_amount_$i'] = "200";
      map['fn_price_$i'] = "200";
      map['fn_price_finish_$i'] = "0";
      map['fn_weigth_$i'] = "0.001";
      map['fn_weigth_finish_$i'] = "0";
      map['fn_weigth_item_$i'] = "0.001";

    });

    map['fn_total_amount2'] = "8400";
    map['fn_total_amount'] = "8400";
    map['fn_total_weigth'] = "0.012";

    map['total_row'] = transactionModel.listBasketModel.length;
    map['company_id'] = "1";
    map['company_provinces_id'] = "9";
    map['company_regencies_id'] = "23";
    map['company_id'] = "1";
    map['fn_total_delv'] = "0";
    map['fn_delv_info'] = "Pickup";
    map['fn_delv'] = "DLV001";
    map['delv'] = "DLV00";

    print(jsonEncode(map));

    final response = await http.post(Uri.parse(Constant.apisavetransaction), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id,
      'data': jsonEncode(map)
    });

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      is_loading = false;

      return response;
    } else {
      is_loading = false;
      throw Exception('Failed to get basket.');
    }

  }

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