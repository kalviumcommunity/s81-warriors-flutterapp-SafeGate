import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_status.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final AuthService _auth = AuthService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    if (!firebaseAvailable) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is logged in, fetch their RBAC role and redirect
      final String role = await _auth.getUserRole(user.uid);
      if (!mounted) return;
      
      switch (role) {
        case 'super_admin':
          Navigator.pushReplacementNamed(context, '/superadmin');
          break;
        case 'admin':
          Navigator.pushReplacementNamed(context, '/admin');
          break;
        case 'guard':
          Navigator.pushReplacementNamed(context, '/guard');
          break;
        case 'resident':
        default:
          Navigator.pushReplacementNamed(context, '/dashboard');
          break;
      }
    } else {
      // No user, stop loading and show HomeScreen
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shield, size: 80, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text("Verifying Secure Connection...", style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      );
    }
    
    // Fallback if not logged in
    return const HomeScreen();
  }
}
