
class FinishingModel {

  final String? price_finish_code;
  final String? size_code;
  final String? finish_code;
  final String? finish_text;
  final String? price;
  final String? weight;

  FinishingModel({
    required this.price_finish_code,
    required this.size_code,
    required this.finish_code,
    required this.finish_text,
    required this.price,
    required this.weight,
  });


  factory FinishingModel.fromJson(Map<String, dynamic> json) {
    return FinishingModel(
      price_finish_code: json['price_finish_code'],
      size_code: json['size_code'],
      finish_code: json['finish_code'],
      finish_text: json['finish_text'],
      price: json['price'],
      weight: json['weight'],
    );
  }
}