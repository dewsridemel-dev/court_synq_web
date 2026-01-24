class SynQUser {
  final String id;
  final String user_id;
  final String first_name;
  final String last_name;
  final String phone_number;
  final String email;
  final String designation;
  final bool is_active;
  final bool is_business_owner;
  final DateTime created_at;

  const SynQUser({
    required this.id,
    required this.user_id,
    required this.first_name,
    required this.last_name,
    required this.phone_number,
    required this.email,
    required this.designation,
    required this.is_active,
    required this.is_business_owner,
    required this.created_at,
  });

  factory SynQUser.fromMap(Map<String, dynamic> map) {
    return SynQUser(
      id: map['id'] as String,
      user_id: map['user_id'] as String,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      phone_number: map['phone_number'] as String,
      email: map['email'] as String,
      designation: map['designation'] as String,
      is_active: map['is_active'] as bool,
      is_business_owner: map['is_business_owner'] as bool,
      created_at: DateTime.parse(map['created_at'] as String),
    );
  }
}