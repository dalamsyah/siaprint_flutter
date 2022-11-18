import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/user_model.dart';

class BasketService {

  List<BasketModel> listBasket = [];
  List<BasketModel> listToPrint = [];

  bool is_loading = false;

  Future<http.Response> getBasket() async {

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    final response = await http.post(Uri.parse(Constant.basket), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id
    });

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      var dataListBasket = data['result']['basket'] as List;

      listBasket = dataListBasket.map((data) => BasketModel.fromJson2(data) ).toList();

      is_loading = false;

      return response;
    } else {
      is_loading = false;
      throw Exception('Failed to get basket.');
    }

  }

  Future<List<BasketModel>> getBasket2() async {

    // await Future.delayed(Duration(seconds: 3), () {
    //   print("Future.delayed");
    // });

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    final response = await http.post(Uri.parse(Constant.basket), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id
    });

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      var dataListBasket = data['result']['basket'] as List;

      listBasket = dataListBasket.map((data) => BasketModel.fromJson2(data) ).toList();

      is_loading = false;

      return listBasket;
    } else {
      is_loading = false;
      throw Exception('Failed to get basket.');
    }

  }

  Future<List<BasketModel>> deleteFileBasket(List<BasketModel> basketModels) async {

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    final response = await http.post(Uri.parse(Constant.apideletefilebasket), body: {
      'apitoken': Constant.apitoken,
      'userid': userModel.id,
      'baskets': jsonEncode(basketModels)
    });

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      var dataListBasket = data['result']['basket'] as List;

      is_loading = false;

      return dataListBasket.map((data) => BasketModel.fromJson2(data) ).toList();
    } else {
      is_loading = false;
      throw Exception('Failed to get delet basket.');
    }

  }

}