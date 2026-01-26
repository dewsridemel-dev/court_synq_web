import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  User? _user;
  SynQUser? _synQUser;
  bool _isLoading = false;

  User? get user => _user;
  SynQUser? get synQUser => _synQUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  void setUser(SynQUser user) {
    _synQUser = user;
  }

  AuthService() {
    _user = _client.auth.currentUser;
    _client.auth.onAuthStateChange.listen((data) {
      _user = data.session?.user;
      notifyListeners();
    });
  }

  Future<bool> signIn(String username, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Supabase uses email for authentication
      // If you're using username, you might need to query your users table first
      // For now, assuming username is email or you have a users table
      final response = await _client.auth.signInWithPassword(
        email: username, // or query users table to get email from username
        password: password,
      );
      
      if (response.user != null) {
        // Get User Details from profiles table
        final Map<String, dynamic> userResponce = await _client
            .from('synq_user')
            .select('''
              id,
              user_id,
              first_name,
              last_name,
              phone_number,
              email,
              designation,
              is_active,
              is_business_owner,
              created_at
            ''')
            .eq('id', response.user!.id)
            .single();

        _synQUser = SynQUser.fromMap(userResponce);
        setUser(_synQUser!);
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('supabase_session', response.session?.accessToken ?? '');
        _isLoading = false;
        notifyListeners();
        return true;
      }

      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Sign in error: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
      _user = null;
      _synQUser = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('supabase_session');
      notifyListeners();
    } catch (e) {
      print('Sign out error: $e');
    }
  }
}