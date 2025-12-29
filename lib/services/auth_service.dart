// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;
    // Create user doc in Firestore with default role 'user'
    await _firestore.collection('users').doc(uid).set({
      'email': email,
      'role': 'user', // default role
      'createdAt': FieldValue.serverTimestamp(),
      // add other profile fields if you want
    });

    // Send email verification
    await userCredential.user!.sendEmailVerification();

    return userCredential;
  }

  // Sign in
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Send password reset email
  Future<void> resetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Verify password reset code and reset password
  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) async {
    await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
  }

  // Update password for logged-in user
  Future<void> updatePassword({required String newPassword}) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
      await user.reload();
    } else {
      throw Exception('No user is currently signed in');
    }
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream (useful for listening)
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
