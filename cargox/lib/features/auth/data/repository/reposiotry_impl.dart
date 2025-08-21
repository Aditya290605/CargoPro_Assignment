// data/repositories/auth_repository_impl.dart
import 'package:cargox/features/auth/data/datascource/datasource.dart';
import 'package:cargox/features/auth/domain/repository/auth_repsitory.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthSource src;
  OtpSession? _lastSession;

  AuthRepositoryImpl(this.src);

  @override
  Future<void> ensureWebPersistenceIfNeeded() =>
      src.ensureWebPersistenceIfNeeded();

  @override
  Stream<User?> authStateChanges() => src.authStateChanges();

  @override
  Future<OtpSession> sendOtp({required String e164Phone}) async {
    final res = await src.sendOtp(e164Phone);
    _lastSession = OtpSession(
      verificationId: res.verificationId,
      confirmation: res.confirmation,
    );
    return _lastSession!;
  }

  @override
  Future<UserCredential> verifyOtp({
    required String smsCode,
    required OtpSession session,
  }) {
    return src.verifyOtp(
      smsCode: smsCode,
      verificationId: session.verificationId,
      confirmation: session.confirmation,
    );
  }

  @override
  Future<void> upsertUserDoc(User user) => src.upsertUserDoc(user);

  @override
  Future<void> signOut() => src.signOut();
}
