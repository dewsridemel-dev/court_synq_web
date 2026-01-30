import 'package:court_synq_web/data/models/business.dart';
import 'package:court_synq_web/data/models/business_doc.dart';
import 'package:court_synq_web/data/repositories/business_repository.dart';

class BusinessService {
  final BusinessRepository repository;

  BusinessService(this.repository);
  
  Future<Business> createBusiness({
    required String registration_no,
    required String name,
    required String phone_number,
    required String email,
    required String website,
    required String address,
    required String city,
    required String province,
    required String owner_id,
    required List<BusinessDoc> business_doc,
  }) async {
    final business = await repository.createBusiness(
      Business(id: '', registration_no: registration_no, name: name, phone_number: phone_number, email: email, website: website, address: address, city: city, province: province, owner_id: owner_id, business_doc: business_doc),
    );
  }
  
//   Future<Business> getBusinessById(String id) async {
//     return await repository.getBusinessById(id);
//   }

//   Future<List<Business>> getAllBusinesses() async {
//     return await repository.getAllBusinesses();
//   }

//   Future<void> updateBusiness(Business business) async {
//     await repository.updateBusiness(business);
//   }

//   Future<void> deleteBusiness(String id) async {
//     await repository.deleteBusiness(id);
//   }
}