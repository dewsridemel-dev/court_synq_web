import 'business_doc.dart';

class Business {
  final String id;
  final String registration_no;
  final String name;
  final String phone_number;
  final String email;
  final String website;
  final String address;
  final String city;
  final String province;
  final String created_at;
  final String owner_id;
  final List<BusinessDoc>? documents;

  const Business({
    required this.id,
    required this.registration_no,
    required this.name,
    required this.phone_number,
    required this.email,
    required this.website,
    required this.address,
    required this.city,
    required this.province,
    required this.created_at,
    required this.owner_id,
    this.documents,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      registration_no: json['registration_no'],
      name: json['name'],
      phone_number: json['phone_number'],
      email: json['email'],
      website: json['website'],
      address: json['address'],
      city: json['city'],
      province: json['province'],
      created_at: json['created_at'],
      owner_id: json['owner_id'],
      documents: json['documents'] != null
          ? (json['documents'] as List)
              .map((e) => BusinessDoc.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'registration_no': registration_no,
      'name': name,
      'phone_number': phone_number,
      'email': email,
      'website': website,
      'address': address,
      'city': city,
      'province': province,
      'created_at': created_at,
      'owner_id': owner_id,
      'documents': documents?.map((e) => e.toJson()).toList(),
    };
  }
}