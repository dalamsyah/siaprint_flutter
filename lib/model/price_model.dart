
class PriceModel {

  final String? price_code;
  final String? size_code;
  final String? ink_code;
  final String? type_paper_code;
  final String? price;
  final String? size_name;
  final String? ink_name;
  final String? type_paper_name;

  PriceModel({
    required this.price_code,
    required this.size_code,
    required this.ink_code,
    required this.type_paper_code,
    required this.price,
    required this.size_name,
    required this.ink_name,
    required this.type_paper_name,
  });


  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      price_code: json['price_code'],
      size_code: json['size_code'],
      ink_code: json['ink_code'],
      type_paper_code: json['type_paper_code'],
      price: json['price'],
      size_name: json['size_name'],
      ink_name: json['ink_name'],
      type_paper_name: json['type_paper_name'],
    );
  }
}