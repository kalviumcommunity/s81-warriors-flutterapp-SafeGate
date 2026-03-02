import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    if (_auth == null) return null;
    try {
      UserCredential result = await _auth!.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future<User?> signUp(String email, String password) async {
    if (_auth == null) return null;
    try {
      UserCredential result = await _auth!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    if (_auth != null) await _auth!.signOut();
  }

  // Google Sign In
  Future<User?> signInWithGoogle() async {
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
      return result.user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Stream of auth changes
  Stream<User?> get user {
    if (_auth == null) return const Stream<User?>.empty();
    return _auth!.authStateChanges();
  }
}
