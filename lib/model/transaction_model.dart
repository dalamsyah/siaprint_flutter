
import 'package:siapprint/model/basket_model.dart';

class TransactionModel {

  List<BasketModel> listBasketModel;
  int total_print = 0;
  int? delivery_id;
  String? delivery_code;
  int total = 0;

  TransactionModel({
    required this.listBasketModel,
    required this.total_print,
    required this.delivery_id,
    required this.delivery_code,
    required this.total,
  });

  Map<String, dynamic> toJson(){
    return {
      "listBasketModel": listBasketModel,
      "total_print": total_print,
      "delivery_id": delivery_id,
      "delivery_code": delivery_code,
      "total": total,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      listBasketModel: json['listBasketModel'],
      total_print: json['total_print'],
      delivery_id: json['delivery_id'],
      delivery_code: json['delivery_code'],
      total: json['total'],
    );
  }

  factory TransactionModel.fromJson2(dynamic json) {
    return TransactionModel(
      listBasketModel: json['listBasketModel'],
      total_print: json['total_print'],
      delivery_id: json['delivery_id'],
      delivery_code: json['delivery_code'],
      total: json['total'],
    );
  }

  @override
  String toString() {
    return 'TransactionModel{listBasketModel: $listBasketModel, total_print: $total_print, delivery_id: $delivery_id, delivery_code: $delivery_code, total: $total}';
  }
}