import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/payment_type_model.dart';
import 'package:siapprint/model/status_model.dart';
import 'package:siapprint/model/user_model.dart';

class StatusService {

  bool is_loading = false;
  List<PaymentTypeModel> paymentTypeList = [];

  Future<List<StatusModel>> getListStatus(String statuscode) async {

    is_loading = true;
    paymentTypeList = [];

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
      var listPaymentType = data['result']['payment_type'] as List;

      var listData = list.map((data) => StatusModel.fromJson2(data) ).toList();
      var listDataPaymentType = listPaymentType.map((data) => PaymentTypeModel.fromJson2(data) ).toList();
      paymentTypeList = List.from(paymentTypeList)..addAll(listDataPaymentType);

      return listData;
    } else {
      is_loading = false;
      throw Exception('Failed to get status list.');
    }

  }

  Future<String> cancelTransaction(String transCode) async {

    // await Future.delayed(Duration(seconds: 5), () {
    //   print("Future.delayed");
    // });

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    final response = await http.post(Uri.parse(Constant.apistatuscancel), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id,
      'trsc_no': transCode,
    });

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return data['message'];
    } else {
      is_loading = false;
      throw Exception('Failed to cancel status.');
    }

  }


  Future<String> payment(PaymentTypeModel paymentTypeModel, String paymentNo, String totalAmount, String phoneNo) async {

    // await Future.delayed(Duration(seconds: 3), () {
    //   print("Future.delayed");
    // });
    //
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));
    //
    // final data = {
    //   'apitoken': Constant.apitoken,
    //   'userid': userModel.id,
    //   'payment_no': payment_no,
    //   'total_amount': total_amount,
    //   'payment_type': paymentTypeModel.payment_type_code,
    //   'payment_name': paymentTypeModel.payment_type_name,
    //   'phone_no': phone_no,
    //   'vendor_code': paymentTypeModel.vendor_code,
    // };
    // print(data);
    //
    // return 'OKE';

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    final data = {
      'apitoken': Constant.apitoken,
      'userid': userModel.id,
      'payment_no': paymentNo,
      'total_amount': totalAmount,
      'payment_type': paymentTypeModel.payment_type_code,
      'payment_name': paymentTypeModel.payment_type_name,
      'phone_no': phoneNo,
      'vendor_code': paymentTypeModel.vendor_code,
    };
    print(data);

    final response = await http.post(Uri.parse(Constant.apipayment), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id,
      'payment_no': paymentNo,
      'total_amount': totalAmount,
      'payment_type': paymentTypeModel.payment_type_code,
      'payment_name': paymentTypeModel.payment_type_name,
      'phone_no': phoneNo,
      'vendor_code': paymentTypeModel.vendor_code,
    });

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      print(data);

      return data['message'];
    } else {
      is_loading = false;
      throw Exception('Failed to cancel status.');
    }

  }

}