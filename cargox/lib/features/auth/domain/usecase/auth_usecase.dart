import 'package:cargox/features/auth/domain/repository/auth_repsitory.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendOtp {
  final AuthRepository repo;
  SendOtp(this.repo);
  Future<OtpSession> call(String e164Phone) =>
      repo.sendOtp(e164Phone: e164Phone);
}

class VerifyOtp {
  final AuthRepository repo;
  VerifyOtp(this.repo);
  Future<UserCredential> call(String code, OtpSession session) =>
      repo.verifyOtp(smsCode: code, session: session);
}

class AuthStateStream {
  final AuthRepository repo;
  AuthStateStream(this.repo);
  Stream<User?> call() => repo.authStateChanges();
}

class UpsertUser {
  final AuthRepository repo;
  UpsertUser(this.repo);
  Future<void> call(User user) => repo.upsertUserDoc(user);
}

class SignOut {
  final AuthRepository repo;
  SignOut(this.repo);
  Future<void> call() => repo.signOut();
}
