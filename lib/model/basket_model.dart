
class BasketModel {

  final String? id;
  final String? user_id;
  final String? filename;
  final String? pages_tot;
  final String? slug;
  final String? filename_random;
  final String? created_at;
  final String? updated_at;
  final String? deleted_at;

  BasketModel({
    required this.id,
    required this.user_id,
    required this.filename,
    required this.pages_tot,
    required this.slug,
    required this.filename_random,
    required this.created_at,
    required this.updated_at,
    required this.deleted_at,
  });


  factory BasketModel.fromJson(Map<String, dynamic> json) {
    return BasketModel(
      id: json['id'],
      user_id: json['user_id'],
      filename: json['filename'],
      pages_tot: json['pages_tot'],
      slug: json['slug'],
      filename_random: json['filename_random'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      deleted_at: json['deleted_at'],
    );
  }

  factory BasketModel.fromJson2(dynamic json) {
    return BasketModel(
      id: json['id'],
      user_id: json['user_id'],
      filename: json['filename'],
      pages_tot: json['pages_tot'],
      slug: json['slug'],
      filename_random: json['filename_random'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      deleted_at: json['deleted_at'],
    );
  }


}