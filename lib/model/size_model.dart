
import 'dart:collection';

import 'package:siapprint/model/price_model.dart';

class SizeModel {

  final String? size_code;
  final String? size_name;
  final String? size_detail;
  final String? size_text;
  final String? active;
  final String? weight;
  final String? uom;
  final dynamic prices;

  SizeModel({
    required this.size_code,
    required this.size_name,
    required this.size_detail,
    required this.size_text,
    required this.active,
    required this.weight,
    required this.uom,
    required this.prices,
  });

  Map<String, dynamic> toJson() {
    return {
      'size_code': size_code,
      'size_name': size_name,
      'size_detail': size_detail,
      'size_text': size_text,
      'active': active,
      'weight': weight,
      'uom': uom,
      'prices': prices,
    };
  }

  factory SizeModel.fromJson(Map<String, dynamic> json) {
    return SizeModel(
      size_code: json['size_code'],
      size_name: json['size_name'],
      size_detail: json['size_detail'],
      size_text: json['size_text'],
      active: json['active'],
      weight: json['weight'],
      uom: json['uom'],
      prices: json['prices'],
    );
  }

  factory SizeModel.fromJson2(dynamic json) {
    return SizeModel(
      size_code: json['size_code'],
      size_name: json['size_name'],
      size_detail: json['size_detail'],
      size_text: json['size_text'],
      active: json['active'],
      weight: json['weight'],
      uom: json['uom'],
      prices: json['prices'].cast<PriceModel>(),
    );
  }

}