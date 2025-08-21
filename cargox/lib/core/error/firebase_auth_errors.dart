import 'package:firebase_auth/firebase_auth.dart';

String authErrorMessage(Object e) {
  if (e is FirebaseAuthException) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'Invalid phone number (use E.164, e.g. +919876543210).';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      case 'invalid-verification-code':
        return 'Incorrect OTP. Please recheck.';
      case 'session-expired':
        return 'OTP session expired. Request a new code.';
      case 'missing-verification-id':
        return 'Verification ID missing. Please resend OTP.';
      case 'missing-confirmation':
        return 'Confirmation missing (web). Please resend OTP.';
      default:
        return e.message ?? 'Authentication failed.';
    }
  }
  return 'Something went wrong.';
}
