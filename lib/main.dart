import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/supabase_service.dart';
import 'services/auth_service.dart';
import 'pages/login_page.dart';
import 'pages/landing_page.dart';
import 'configs/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //final Config config = const Config();

  await Supabase.initialize(
    //url: config._db_url,
    //anonKey: config._anon_key,
    url: 'https://fzigdqfiuryluqsrmrjl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ6aWdkcWZpdXJ5bHVxc3JtcmpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjczNzE4NzMsImV4cCI6MjA4Mjk0Nzg3M30.EVk4MPxHte8-nw7BAT8i5miHrWsyrXFucTP6Rkzmwis',
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => SupabaseService()),
      ],
      child: MaterialApp(
        title: 'Court SynQ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple,
            brightness: Brightness.light,
          ),
        ),
        home: const AuthWrapper(),
        routes: {
          '/landing': (context) => const LandingPage(),
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final session = prefs.getString('supabase_session');
    
    if (session != null) {
      try {
        final supabase = Supabase.instance.client;
        final user = supabase.auth.currentUser;
        if (user != null) {
          setState(() {
            _isAuthenticated = true;
            _isLoading = false;
          });
          return;
        }
      } catch (e) {
        // Session invalid, clear it
        await prefs.remove('supabase_session');
      }
    }
    
    setState(() {
      _isAuthenticated = false;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _isAuthenticated ? const LandingPage() : const LoginPage();
  }
}