import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  AuthService() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  User? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<void> _onAuthStateChanged(User? user) async {
    _user = user;
    notifyListeners();
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message on failure
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
