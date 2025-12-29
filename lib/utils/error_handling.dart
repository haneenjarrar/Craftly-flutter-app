import 'package:firebase_auth/firebase_auth.dart';

class ErrorHandling {
  static String getAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with that email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'requires-recent-login':
        return 'Please log out and log in again before changing password.';
      case 'invalid-email':
        return 'Invalid email address.';
      default:
        return e.message ?? 'An error occurred';
    }
  }

  static String getErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      return getAuthErrorMessage(error);
    }
    return error.toString();
  }
}

