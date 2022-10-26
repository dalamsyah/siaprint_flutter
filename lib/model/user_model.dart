
class UserModel {

  final String? id;
  final String? email;
  final String? username;
  final String? password_hash;
  final String? reset_hash;
  final String? reset_at;
  final String? reset_expires;
  final String? activate_hash;
  final String? status;
  final String? status_message;
  final String? active;
  final String? force_pass_reset;
  final String? created_at;
  final String? updated_at;
  final String? deleted_at;
  final String? balance;
  final String? phone;
  final String? first_name;
  final String? last_name;
  final String? admin_comp;
  final String? owner;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password_hash,
    required this.reset_hash,
    required this.reset_at,
    required this.reset_expires,
    required this.activate_hash,
    required this.status,
    required this.status_message,
    required this.active,
    required this.force_pass_reset,
    required this.created_at,
    required this.updated_at,
    required this.deleted_at,
    required this.balance,
    required this.phone,
    required this.first_name,
    required this.last_name,
    required this.admin_comp,
    required this.owner
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password_hash: json['password_hash'],
      reset_hash: json['reset_hash'],
      reset_at: json['reset_at'],
      reset_expires: json['reset_expires'],
      activate_hash: json['activate_hash'],
      status: json['status'],
      status_message: json['status_message'],
      active: json['active'],
      force_pass_reset: json['force_pass_reset'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      deleted_at: json['deleted_at'],
      balance: json['balance'],
      phone: json['phone'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      admin_comp: json['admin_comp'],
      owner: json['owner'],
    );
  }
}