
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:siapprint/model/address_model.dart';

class StatusDetailModel {

  final String? print_h_code;
  final String? created_at;
  final String? amount_h;
  final String? trsc_h_status;
  final String? trsc_h_status_name;
  final String? trsc_h_status_text;
  final String? delv_code;
  final String? delv_name;
  final String? size_code;
  final String? size_name;
  final String? ink_code;
  final String? ink_name;
  final String? type_paper_code;
  final String? type_paper_name;
  final String? finish_code;
  final String? finish_text;
  final String? total_pages;
  final String? pages_remarks;
  final String? amount_d;
  final String? price;
  final String? price_finish;
  final String? filename;
  final String? filename_random;
  final String? copy;
  final String? remarks_d;
  final String? ntgew_h;
  final String? ntgew_uom_h;
  final String? ntgew_d;
  final String? ntgew_uom_d;

  StatusDetailModel({
    required this.print_h_code,
    required this.created_at,
    required this.amount_h,
    required this.trsc_h_status,
    required this.trsc_h_status_name,
    required this.trsc_h_status_text,
    required this.delv_code,
    required this.delv_name,
    required this.size_code,
    required this.size_name,
    required this.ink_code,
    required this.ink_name,
    required this.type_paper_code,
    required this.type_paper_name,
    required this.finish_code,
    required this.finish_text,
    required this.total_pages,
    required this.pages_remarks,
    required this.amount_d,
    required this.price,
    required this.price_finish,
    required this.filename,
    required this.filename_random,
    required this.copy,
    required this.remarks_d,
    required this.ntgew_h,
    required this.ntgew_uom_h,
    required this.ntgew_d,
    required this.ntgew_uom_d,
  });


  factory StatusDetailModel.fromJson(Map<String, dynamic> json) {
    return StatusDetailModel(
      print_h_code: json['print_h_code'],
      created_at: json['created_at'],
      amount_h: json['amount_h'],
      trsc_h_status: json['trsc_h_status'],
      trsc_h_status_name: json['trsc_h_status_name'],
      trsc_h_status_text: json['trsc_h_status_text'],
      delv_code: json['delv_code'],
      delv_name: json['delv_name'],
      size_code: json['size_code'],
      size_name: json['size_name'],
      ink_code: json['ink_code'],
      ink_name: json['ink_name'],
      type_paper_code: json['type_paper_code'],
      type_paper_name: json['type_paper_name'],
      finish_code: json['finish_code'],
      finish_text: json['finish_text'],
      total_pages: json['total_pages'],
      pages_remarks: json['pages_remarks'],
      amount_d: json['amount_d'],
      price: json['price'],
      price_finish: json['price_finish'],
      filename: json['filename'],
      filename_random: json['filename_random'],
      copy: json['copy'],
      remarks_d: json['remarks_d'],
      ntgew_h: json['ntgew_h'],
      ntgew_uom_h: json['ntgew_uom_h'],
      ntgew_d: json['ntgew_d'],
      ntgew_uom_d: json['ntgew_uom_d'],
    );
  }

  factory StatusDetailModel.fromJson2(dynamic json) {
    return StatusDetailModel(
      print_h_code: json['print_h_code'],
      created_at: json['created_at'],
      amount_h: json['amount_h'],
      trsc_h_status: json['trsc_h_status'],
      trsc_h_status_name: json['trsc_h_status_name'],
      trsc_h_status_text: json['trsc_h_status_text'],
      delv_code: json['delv_code'],
      delv_name: json['delv_name'],
      size_code: json['size_code'],
      size_name: json['size_name'],
      ink_code: json['ink_code'],
      ink_name: json['ink_name'],
      type_paper_code: json['type_paper_code'],
      type_paper_name: json['type_paper_name'],
      finish_code: json['finish_code'],
      finish_text: json['finish_text'],
      total_pages: json['total_pages'],
      pages_remarks: json['pages_remarks'],
      amount_d: json['amount_d'],
      price: json['price'],
      price_finish: json['price_finish'],
      filename: json['filename'],
      filename_random: json['filename_random'],
      copy: json['copy'],
      remarks_d: json['remarks_d'],
      ntgew_h: json['ntgew_h'],
      ntgew_uom_h: json['ntgew_uom_h'],
      ntgew_d: json['ntgew_d'],
      ntgew_uom_d: json['ntgew_uom_d'],
    );
  }

}