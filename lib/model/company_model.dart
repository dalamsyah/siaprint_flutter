
class CompanyModel {

  final String? comp_id;
  final String? comp_name;
  final String? comp_address;
  final String? comp_text1;
  final String? provinces_id;
  final String? provinces_name;
  final String? regencies_id;
  final String? regencies_name;
  final String? price_status;
  final String? price_finish_status;

  CompanyModel({
    required this.comp_id,
    required this.comp_name,
    required this.comp_address,
    required this.comp_text1,
    required this.provinces_id,
    required this.provinces_name,
    required this.regencies_id,
    required this.regencies_name,
    required this.price_status,
    required this.price_finish_status,
  });


  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      comp_id: json['comp_id'],
      comp_name: json['comp_name'],
      comp_address: json['comp_address'],
      comp_text1: json['comp_text1'],
      provinces_id: json['provinces_id'],
      provinces_name: json['provinces_name'],
      regencies_id: json['regencies_id'],
      regencies_name: json['regencies_name'],
      price_status: json['price_status'],
      price_finish_status: json['price_finish_status'],
    );
  }

  factory CompanyModel.fromJson2(dynamic json) {
    return CompanyModel(
      comp_id: json['comp_id'],
      comp_name: json['comp_name'],
      comp_address: json['comp_address'],
      comp_text1: json['comp_text1'],
      provinces_id: json['provinces_id'],
      provinces_name: json['provinces_name'],
      regencies_id: json['regencies_id'],
      regencies_name: json['regencies_name'],
      price_status: json['price_status'],
      price_finish_status: json['price_finish_status'],
    );
  }
}