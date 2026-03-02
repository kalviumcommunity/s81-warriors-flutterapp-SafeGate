import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:safegate_app/services/firebase_status.dart';

class AuthService {
  FirebaseAuth? _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthService() {
    if (firebaseAvailable) {
      _auth = FirebaseAuth.instance;
    }
  }

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    if (_auth == null) throw Exception('Firebase is not initialized');
    try {
      UserCredential result = await _auth!.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? e.code);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('pigeon') || msg.contains('PlatformException')) {
        throw Exception('Sign in failed: Please verify Email/Password auth is enabled in Firebase.');
      }
      throw Exception(msg);
    }
  }

  // Register with email and password and explicitly set RBAC Role
  Future<User?> signUp(String email, String password, String initialRole) async {
    if (_auth == null) throw Exception('Firebase is not initialized');
    try {
      UserCredential result = await _auth!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Initialize requested RBAC role upon signup
      if (result.user != null) {
        await FirebaseFirestore.instance.collection('users').doc(result.user!.uid).set({
          'role': initialRole,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? e.code);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('pigeon') || msg.contains('PlatformException')) {
        throw Exception('Registration failed: Please verify Email/Password auth is enabled in Firebase.');
      }
      throw Exception(msg);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    if (_auth != null) await _auth!.signOut();
  }

  // Google Sign In with explicit RBAC Role
  Future<User?> signInWithGoogle(String initialRole) async {
    try {
      if (_auth == null) return null;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth!.signInWithCredential(credential);
      
      // Ensure Google sign-ups also get a default role
      if (result.user != null) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(result.user!.uid).get();
        if (!doc.exists) {
          await FirebaseFirestore.instance.collection('users').doc(result.user!.uid).set({
            'role': initialRole,
            'email': result.user!.email,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }

      return result.user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Fetch the role for the authenticated user to enforce RBAC
  Future<String> getUserRole(String uid) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists && doc.data()!.containsKey('role')) {
        return doc.data()!['role'] as String;
      }
    } catch (e) {
      debugPrint("Failed to fetch user role: $e");
    }
    return 'resident'; // Fallback to lowest privilege
  }

  // Stream of auth changes
  Stream<User?> get user {
    if (_auth == null) return const Stream<User?>.empty();
    return _auth!.authStateChanges();
  }
}
