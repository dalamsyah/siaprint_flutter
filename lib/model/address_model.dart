
class AddressModel {

  String? id;
  String? user_id;
  String? addr_name;
  String? receiver;
  String? address;
  String? postcode;
  String? created_at;
  String? updated_at;
  String? phone;
  String? delete_at;
  String? province_id;
  String? regencies_id;
  String? district_id;
  String? villages_id;
  String? default_addr;

  AddressModel({
      this.id,
      this.user_id,
      this.addr_name,
      this.receiver,
      this.address,
      this.postcode,
      this.created_at,
      this.updated_at,
      this.phone,
      this.delete_at,
      this.province_id,
      this.regencies_id,
      this.district_id,
      this.villages_id,
      this.default_addr});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      user_id: json['user_id'],
      addr_name: json['addr_name'],
      receiver: json['receiver'],
      address: json['address'],
      postcode: json['postcode'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      phone: json['phone'],
      delete_at: json['delete_at'],
      province_id: json['province_id'],
      regencies_id: json['regencies_id'],
      district_id: json['district_id'],
      villages_id: json['villages_id'],
      default_addr: json['default_addr'],
    );
  }

  @override
  String toString() {
    return 'AddressModel{id: $id, user_id: $user_id, addr_name: $addr_name, receiver: $receiver, address: $address, postcode: $postcode, created_at: $created_at, updated_at: $updated_at, phone: $phone, delete_at: $delete_at, province_id: $province_id, regencies_id: $regencies_id, district_id: $district_id, villages_id: $villages_id, default_addr: $default_addr}';
  }
}