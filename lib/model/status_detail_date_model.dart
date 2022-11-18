


class StatusDetailDateModel {

  final String? code;
  final String? name;
  final String? text;
  final String? date;

  StatusDetailDateModel({
    required this.code,
    required this.name,
    required this.text,
    required this.date,
  });


  factory StatusDetailDateModel.fromJson(Map<String, dynamic> json) {
    return StatusDetailDateModel(
      code: json['code'],
      name: json['name'],
      text: json['text'],
      date: json['date'],
    );
  }

  factory StatusDetailDateModel.fromJson2(dynamic json) {
    return StatusDetailDateModel(
      code: json['code'],
      name: json['name'],
      text: json['text'],
      date: json['date'],
    );
  }

}