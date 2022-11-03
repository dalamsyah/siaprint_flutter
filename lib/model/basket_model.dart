
class BasketModel {

  String? id;
  String? user_id;
  String? filename;
  String? pages_tot;
  String? slug;
  String? filename_random;
  String? created_at;
  String? updated_at;
  String? deleted_at;
  bool? is_checked;

  int total = 0;
  int printer = 0;
  String printer_code = '';

  int pages = 0;
  String pagesRange = '';
  String copyPage = '1';
  String notes = '';

  int priceJenisKertas = 0;
  int priceFinishing = 0;

  String ukuranKertas = 'Silahkan pilih';
  String jenisKertas = 'Silahkan pilih';
  String finishing = 'Silahkan pilih';

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
    required this.is_checked,
  });

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "user_id": user_id,
      "filename": filename,
      "pages_tot": pages_tot,
      "slug": slug,
      "filename_random": filename_random,
      "created_at": created_at,
      "updated_at": updated_at,
      "deleted_at": deleted_at,
      "is_checked": is_checked,
    };
  }

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
      is_checked: json['is_checked'],
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
      is_checked: json['is_checked'],
    );
  }

  @override
  String toString() {
    return 'BasketModel{id: $id, user_id: $user_id, filename: $filename, pages_tot: $pages_tot, slug: $slug, filename_random: $filename_random, created_at: $created_at, updated_at: $updated_at, deleted_at: $deleted_at, is_checked: $is_checked, total: $total, printer: $printer, printer_code: $printer_code, pages: $pages, pagesRange: $pagesRange, copyPage: $copyPage, notes: $notes, ukuranKertas: $ukuranKertas, jenisKertas: $jenisKertas, finishing: $finishing}';
  }
}