import 'package:court_synq_web/data/datasources/supabase_datasource.dart';

class BusinessRepository {
  final SupabaseDataSource dataSource;

  BusinessRepository(this.dataSource);

  /// Create business
  Future<Business> createBusiness(Business business) async {
    final response = await dataSource.client.rpc(
        'business.create_business',
        params: {
            'registration_no': business.registration_no,
            'name': business.name,
            'phone_number': business.phone_number,
            'email': business.email,
            'website': business.website,
            'address': business.address,
            'city': business.city,
            'province': business.province,
            'owner_id': business.owner_id,
            'business_doc': business.business_doc.map((e) => e.toJson()).toList(),
        },
    );

    return Business.fromJson(response);
  }

//   /// Insert addresses
//   Future<void> addAddresses(List<AppUserAddress> addresses) async {
//     await dataSource.client
//         .from('app_user_address')
//         .insert(addresses.map((e) => e.toJson()).toList());
//   }

//   /// Fetch user with addresses
//   Future<AppUser> getUser(String userId) async {
//     final response = await dataSource.client
//         .from('app_user')
//         .select('*, app_user_address(*)')
//         .eq('id', userId)
//         .single();

//     return AppUser.fromJson(response);
//   }

//   /// Delete user (cascade if FK configured)
//   Future<void> deleteUser(String userId) async {
//     await dataSource.client
//         .from('app_user')
//         .delete()
//         .eq('id', userId);
//   }
}
