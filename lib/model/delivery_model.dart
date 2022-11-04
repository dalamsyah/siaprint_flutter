
class DeliveryModel {

  final String? delv_code;
  final String? delv_name;
  final String? delv_text1;
  final String? active;
  final String? weight_calc;
  final String? checked;
  final String? need_addr;
  int total = 0;

  DeliveryModel({
    required this.delv_code,
    required this.delv_name,
    required this.delv_text1,
    required this.active,
    required this.weight_calc,
    required this.checked,
    required this.need_addr,
    required this.total,
  });


  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return DeliveryModel(
      delv_code: json['delv_code'],
      delv_name: json['delv_name'],
      delv_text1: json['delv_text1'],
      active: json['active'],
      weight_calc: json['weight_calc'],
      checked: json['checked'],
      need_addr: json['need_addr'],
      total: json['total'],
    );
  }

  factory DeliveryModel.fromJson2(dynamic json) {
    return DeliveryModel(
      delv_code: json['delv_code'],
      delv_name: json['delv_name'],
      delv_text1: json['delv_text1'],
      active: json['active'],
      weight_calc: json['weight_calc'],
      checked: json['checked'],
      need_addr: json['need_addr'],
      total: json['total'],
    );
  }
}