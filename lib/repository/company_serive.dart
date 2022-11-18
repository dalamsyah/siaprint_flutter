import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/address_model.dart';
import 'package:siapprint/model/company_model.dart';
import 'package:siapprint/model/provinsi_model.dart';
import 'package:siapprint/model/user_model.dart';

class CompanyService {

  List<CompanyModel> listCompany = [];
  List<CompanyModel> allListCompany = [];
  List<CompanyModel> allListCompanyFilter = [];
  List<ProvinsiModel> listProvince = [];

  bool is_loading = false;
  String msg = '';

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
      var dataAllListCompany = data['result']['company'] as List;
      var dataListProvince = data['result']['provinces_regencies_existing'] as List;
      var address = data['result']['address'];

      if (address != null) {
        AddressModel addressModel = AddressModel.fromJson(address);

        localStorage.setString('address', jsonEncode(address));

      }

      msg = data['message'].toString();
      listCompany = dataListCompany.map((data) => CompanyModel.fromJson2(data) ).toList();
      allListCompany = dataAllListCompany.map((data) => CompanyModel.fromJson2(data) ).toList();
      listProvince = dataListProvince.map((data) => ProvinsiModel.fromJson2(data) ).toList();

      is_loading = false;

      return response;
    } else {
      is_loading = false;
      throw Exception('Failed to get company.');
    }

  }

  // void _chooseOtherTapPlace() async {
  //   print(data.length);
  //   _provinsi = List.from(_provinsi)..addAll(await _companyService.getProvinsiByUser(data));
  // }

  Future<List<CompanyModel>> getCompanyFilter(String provincesId) async {

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));
    // AddressModel addressModel = AddressModel.fromJson(userModel.address);

    // if (provinces_id == '') {
    //   provinces_id = addressModel.province_id!;
    // }

    final response = await http.post(Uri.parse(Constant.apicompanyfromprovince), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id,
      'provinces_id': provincesId,
    });

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      var dataAllListCompany = data['result']['company'] as List;

      allListCompanyFilter = dataAllListCompany.map((data) => CompanyModel.fromJson2(data) ).toList();

      is_loading = false;

      return allListCompanyFilter;
    } else {
      is_loading = false;
      throw Exception('Failed to get filter company.');
    }

  }

  Future<List<String>> getProvinsiByUser(List<ProvinsiModel> data) async {

    return Future.value(data.map((e) => e.provinces_id!).toList());

  }

  List<String> getAllProvinsiByUser(List<ProvinsiModel> data, String s) {

    return data.where((element) => element.provinces_id == s).map((e) => e.provinces_name!).toList();

  }

}