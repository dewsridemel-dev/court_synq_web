import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  SupabaseClient get client => _client;

  // Insert a new booking into the database
  Future<Map<String, dynamic>?> insertBooking({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required int numberOfParticipants,
    required String courtId,
    required DateTime startTime,
    required DateTime endTime,
    required double hourlyRate,
    required double totalAmount,
    required String paymentMethod,
    required bool isPaid,
  }) async {
    try {
      final response = await _client
          .from('bookings')
          .insert({
            'first_name': firstName,
            'last_name': lastName,
            'email': email,
            'phone_number': phoneNumber,
            'number_of_participants': numberOfParticipants,
            'court_id': courtId,
            'start_time': startTime.toIso8601String(),
            'end_time': endTime.toIso8601String(),
            'hourly_rate': hourlyRate,
            'total_amount': totalAmount,
            'payment_method': paymentMethod,
            'is_paid': isPaid,
            'status': isPaid ? 'confirmed' : 'pending',
            'created_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      return response;
    } catch (e) {
      print('Error inserting booking: $e');
      rethrow;
    }
  }

  // Get user bookings
  Future<List<Map<String, dynamic>>> getUserBookings() async {
    try {
      final response = await _client
          .from('bookings')
          .select()
          .order('created_at', ascending: false);
      
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching bookings: $e');
      return [];
    }
  }
}