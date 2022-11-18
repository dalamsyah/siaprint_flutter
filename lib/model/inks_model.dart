

class InkModel {

  final String? ink_code;
  final String? ink_name;
  final List<dynamic>? size;

  InkModel({
    required this.ink_code,
    required this.ink_name,
    required this.size,
  });


  factory InkModel.fromJson(Map<String, dynamic> json) {
    return InkModel(
      ink_code: json['ink_code'],
      ink_name: json['ink_name'],
      size: json['size'],
    );
  }

  factory InkModel.fromJson2(dynamic json) {
    return InkModel(
      ink_code: json['ink_code'],
      ink_name: json['ink_name'],
      size: json['size'],
    );
  }

  @override
  String toString() {
    return 'InkModel{ink_code: $ink_code, ink_name: $ink_name, size: $size}';
  }
}