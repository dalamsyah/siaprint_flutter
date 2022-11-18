import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/address_model.dart';
import 'package:siapprint/model/transaction_model.dart';
import 'package:siapprint/model/user_model.dart';

class CheckoutService {

  bool is_loading = false;
  String msg = '';

  Future<http.Response> saveTransaction(TransactionModel transactionModel) async {

    // await Future.delayed(const Duration(seconds: 3), () {
    //   print("Future.delayed");
    // });

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    AddressModel addressModel = AddressModel.fromJson(jsonDecode(localStorage.getString('address')!));

    Map<String, dynamic> map = {};
    map['fn_addr_default_regencies_id'] = addressModel.regencies_id;
    map['fn_addr_default_provinces_id'] = addressModel.province_id;
    map['fn_addr_default_address'] = addressModel.address;
    map['fn_addr_default_regencies_name'] = addressModel.regency_name;
    map['fn_addr_default_provinces_name'] = addressModel.province_name;
    map['fn_addr_default_postcode'] = addressModel.postcode;
    map['fn_addr_default_phone'] = addressModel.phone;
    map['fn_addr_default_receiver'] = addressModel.receiver;

    transactionModel.listBasketModel.asMap().forEach((i, value) {

      map['check_ink_$i'] = value.printer_code;
      map['id_papper_$i'] = value.ukuranKertas;
      map['type_paper_$i'] = value.jenisKertas;
      map['pages_$i'] = value.pages;
      map['count_print_$i'] = value.copyPage;
      map['finishing_$i'] = value.finishing;
      map['remarks_$i'] = value.notes;
      map['fn_temp_$i'] = value.id;
      map['fn_filename_$i'] = value.filename;
      map['fn_filename_random_$i'] = value.filename_random;
      map['fn_size_code_$i'] = value.ukuranKertas;
      map['fn_ink_code_$i'] = value.printer_code;
      map['fn_type_paper_code_$i'] = value.jenisKertas;
      map['fn_copy_$i'] = value.copyPage;
      map['fn_finish_code_$i'] = value.finishing;
      map['fn_pages_$i'] = value.pages;
      map['fn_amount_$i'] = value.total;
      map['fn_price_$i'] = value.priceJenisKertas;
      map['fn_price_finish_$i'] = value.priceFinishing;
      map['fn_weigth_$i'] = value.weightJenisKertas;
      map['fn_weigth_finish_$i'] = value.weightFinishing;
      map['fn_weigth_item_$i'] = value.totalWeight;

    });

    map['fn_total_amount2'] = transactionModel.total; //grand total
    map['fn_total_amount'] = transactionModel.total_print;
    map['fn_total_weigth'] = transactionModel.total_weight;

    map['total_row'] = transactionModel.listBasketModel.length;
    map['company_id'] = transactionModel.companyModel.comp_id;
    map['company_provinces_id'] = transactionModel.companyModel.provinces_id;
    map['company_regencies_id'] = transactionModel.companyModel.regencies_id;
    map['fn_total_delv'] = transactionModel.deliveryModel?.total;
    map['fn_delv_info'] = transactionModel.deliveryModel?.delv_name;
    map['fn_delv'] = transactionModel.deliveryModel?.delv_code;
    map['delv'] = transactionModel.deliveryModel?.delv_code;

    // return http.Response('', 200);

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

      msg = 'Failed to save basket.';

      throw Exception('Failed to save basket.');
    }

  }

  Future<http.Response> getDeliveryList() async {

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    final response = await http.post(Uri.parse(Constant.apideliverylist), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id,
    });

    if (response.statusCode == 200) {

      is_loading = false;

      return response;
    } else {
      is_loading = false;
      throw Exception('Failed to get delivery list.');
    }

  }

  Future<http.Response> getDeliveryJNE(
  String delvCode,
  String provincesIdFrom,
  String regenciesIdFrom,
  String totalWeigth,
      ) async {

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));
    AddressModel addressModel = AddressModel.fromJson(jsonDecode(localStorage.getString('address')!));

    final response = await http.post(Uri.parse(Constant.apijne), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id,
      'delv_code':delvCode,
      'provinces_id_from': provincesIdFrom,
      'regencies_id_from': regenciesIdFrom,
      'provinces_id_to': addressModel.province_id,
      'regencies_id_to': addressModel.regencies_id,
      'total_weigth':totalWeigth,
    });

    if (response.statusCode == 200) {

      is_loading = false;

      return response;
    } else {
      is_loading = false;
      throw Exception('Failed to get delivery JNE.');
    }

  }

}