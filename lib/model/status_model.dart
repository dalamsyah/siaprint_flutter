
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:siapprint/model/address_model.dart';
import 'package:siapprint/model/status_detail_model.dart';

class StatusModel {

  final String? print_h_code;
  final String? created_at;
  final String? amount_h;
  final String? trsc_h_status;
  final String? trsc_h_status_name;
  final String? trsc_h_status_text;
  final String? delv_code;
  final String? delv_name;
  final String? company_name;
  final String? provinces_name;
  final String? regencies_name;
  final String? comp_address;
  final String? ntgew_h;
  final String? ntgew_uom_h;
  final String? delv_cost;
  final String? amount_p;
  final String? delv_text;
  final String? shipp_receiver;
  final String? shipp_phone;
  final String? shipp_address;
  final String? shipp_postcode;
  final String? delv_text2;
  final dynamic status_detail;

  StatusModel({
    required this.print_h_code,
    required this.created_at,
    required this.amount_h,
    required this.trsc_h_status,
    required this.trsc_h_status_name,
    required this.trsc_h_status_text,
    required this.delv_code,
    required this.delv_name,
    required this.company_name,
    required this.provinces_name,
    required this.regencies_name,
    required this.comp_address,
    required this.ntgew_h,
    required this.ntgew_uom_h,
    required this.delv_cost,
    required this.amount_p,
    required this.delv_text,
    required this.shipp_receiver,
    required this.shipp_phone,
    required this.shipp_address,
    required this.shipp_postcode,
    required this.delv_text2,
    required this.status_detail,
  });


  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      print_h_code: json['print_h_code'],
      created_at: json['created_at'],
      amount_h: json['amount_h'],
      trsc_h_status: json['trsc_h_status'],
      trsc_h_status_name: json['trsc_h_status_name'],
      trsc_h_status_text: json['trsc_h_status_text'],
      delv_code: json['delv_code'],
      delv_name: json['delv_name'],
      company_name: json['company_name'],
      provinces_name: json['provinces_name'],
      regencies_name: json['regencies_name'],
      comp_address: json['comp_address'],
      ntgew_h: json['ntgew_h'],
      ntgew_uom_h: json['ntgew_uom_h'],
      delv_cost: json['delv_cost'],
      amount_p: json['amount_p'],
      delv_text: json['delv_text'],
      shipp_receiver: json['shipp_receiver'],
      shipp_phone: json['shipp_phone'],
      shipp_address: json['shipp_address'],
      shipp_postcode: json['shipp_postcode'],
      delv_text2: json['delv_text2'],
      status_detail: json['trsc_print_d'],
    );
  }

  factory StatusModel.fromJson2(dynamic json) {
    return StatusModel(
      print_h_code: json['print_h_code'],
      created_at: json['created_at'],
      amount_h: json['amount_h'],
      trsc_h_status: json['trsc_h_status'],
      trsc_h_status_name: json['trsc_h_status_name'],
      trsc_h_status_text: json['trsc_h_status_text'],
      delv_code: json['delv_code'],
      delv_name: json['delv_name'],
      company_name: json['company_name'],
      provinces_name: json['provinces_name'],
      regencies_name: json['regencies_name'],
      comp_address: json['comp_address'],
      ntgew_h: json['ntgew_h'],
      ntgew_uom_h: json['ntgew_uom_h'],
      delv_cost: json['delv_cost'],
      amount_p: json['amount_p'],
      delv_text: json['delv_text'],
      shipp_receiver: json['shipp_receiver'],
      shipp_phone: json['shipp_phone'],
      shipp_address: json['shipp_address'],
      shipp_postcode: json['shipp_postcode'],
      delv_text2: json['delv_text2'],
      status_detail: json['trsc_print_d'],
    );
  }

}