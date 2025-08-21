import 'package:firebase_auth/firebase_auth.dart';

class OtpSession {
  final String? verificationId;
  final ConfirmationResult? confirmation;
  const OtpSession({this.verificationId, this.confirmation});
}

abstract class AuthRepository {
  Future<OtpSession> sendOtp({required String e164Phone});
  Future<UserCredential> verifyOtp({
    required String smsCode,
    required OtpSession session,
  });
  Future<void> upsertUserDoc(User user);
  Stream<User?> authStateChanges();
  Future<void> signOut();
  Future<void> ensureWebPersistenceIfNeeded();
}
