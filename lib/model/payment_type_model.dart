



class PaymentTypeModel {

  final String? payment_category;
  final String? payment_type_code;
  final String? payment_type_name;
  final String? payment_type_text;
  final String? active;
  final String? vendor_code;

  PaymentTypeModel({
    required this.payment_category,
    required this.payment_type_code,
    required this.payment_type_name,
    required this.payment_type_text,
    required this.active,
    required this.vendor_code,
  });


  factory PaymentTypeModel.fromJson(Map<String, dynamic> json) {
    return PaymentTypeModel(
      payment_category: json['payment_category'],
      payment_type_code: json['payment_type_code'],
      payment_type_name: json['payment_type_name'],
      payment_type_text: json['payment_type_text'],
      active: json['active'],
      vendor_code: json['vendor_code'],
    );
  }

  factory PaymentTypeModel.fromJson2(dynamic json) {
    return PaymentTypeModel(
      payment_category: json['payment_category'],
      payment_type_code: json['payment_type_code'],
      payment_type_name: json['payment_type_name'],
      payment_type_text: json['payment_type_text'],
      active: json['active'],
      vendor_code: json['vendor_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_category': payment_category,
      'payment_type_code': payment_type_code,
      'payment_type_name': payment_type_name,
      'payment_type_text': payment_type_text,
      'active': active,
      'vendor_code': vendor_code,
    };
  }

}