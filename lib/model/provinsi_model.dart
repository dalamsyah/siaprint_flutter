
class ProvinsiModel {

  final String? provinces_id;
  final String? provinces_name;
  final String? regencies_id;
  final String? regencies_name;

  ProvinsiModel({
    required this.provinces_id,
    required this.provinces_name,
    required this.regencies_id,
    required this.regencies_name,
  });


  factory ProvinsiModel.fromJson(Map<String, dynamic> json) {
    return ProvinsiModel(
      provinces_id: json['provinces_id'],
      provinces_name: json['provinces_name'],
      regencies_id: json['regencies_id'],
      regencies_name: json['regencies_name'],
    );
  }

  factory ProvinsiModel.fromJson2(dynamic json) {
    return ProvinsiModel(
      provinces_id: json['provinces_id'],
      provinces_name: json['provinces_name'],
      regencies_id: json['regencies_id'],
      regencies_name: json['regencies_name'],
    );
  }

}