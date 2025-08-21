// presentation/controllers/auth_controller.dart
import 'package:cargox/core/error/firebase_auth_errors.dart';
import 'package:cargox/core/utils/json_validator.dart';
import 'package:cargox/features/auth/domain/repository/auth_repsitory.dart';
import 'package:cargox/features/auth/domain/usecase/auth_usecase.dart';
import 'package:cargox/features/auth/presentation/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

enum AuthStatus { idle, sendingOtp, codeSent, verifying, authenticated, error }

class AuthController extends GetxController {
  final SendOtp sendOtp;
  final VerifyOtp verifyOtp;
  final UpsertUser upsertUser;
  final AuthStateStream authStateStream;
  final SignOut signOutUseCase;

  AuthController({
    required this.sendOtp,
    required this.verifyOtp,
    required this.upsertUser,
    required this.authStateStream,
    required this.signOutUseCase,
  });

  final box = GetStorage();
  final status = AuthStatus.idle.obs;
  final errorText = ''.obs;
  final phone = ''.obs;
  final otpCode = ''.obs;
  OtpSession? _session;

  @override
  void onInit() {
    super.onInit();
    _initWebPersistence();
    _listenAuth();
  }

  Future<void> _initWebPersistence() async {
    // On web, make auth persistent across reloads
    try {
      if (kIsWeb) {
        // Using the repository’s web-persistence method via sendOtp’s repo, but we can call directly if you expose it
        // Workaround: call through a quick OTP noop? Better: expose DI repo and call ensureWebPersistenceIfNeeded()
        // If you registered the repo in DI:
        final repo = Get.find<AuthRepository>();
        await repo.ensureWebPersistenceIfNeeded();
      }
    } catch (_) {}
  }

  void _listenAuth() {
    authStateStream().listen((user) async {
      if (user != null) {
        status.value = AuthStatus.authenticated;
        await upsertUser(user);
        box.write('loggedIn', true);
        box.write('uid', user.uid);
        Get.offAllNamed(Routes.home);
      } else {
        box.write('loggedIn', false);
        status.value = AuthStatus.idle;
        if (Get.currentRoute != Routes.login) {
          Get.offAllNamed(Routes.onboarding);
        }
      }
    });
  }

  Future<void> onSendOtp() async {
    errorText.value = '';
    if (!isValidE164(phone.value)) {
      _showError('Enter phone in E.164 format, e.g. +919876543210');
      return;
    }
    try {
      status.value = AuthStatus.sendingOtp;
      _session = await sendOtp(phone.value);
      status.value = AuthStatus.codeSent;
      Get.snackbar(
        'OTP Sent',
        'A verification code was sent to ${phone.value}',
      );
      Get.toNamed(Routes.otp);
    } catch (e) {
      _showError(authErrorMessage(e));
    }
  }

  Future<void> onVerifyCode() async {
    errorText.value = '';
    if ((otpCode.value).length < 6) {
      _showError('Enter the 6-digit OTP');
      return;
    }
    try {
      status.value = AuthStatus.verifying;
      final cred = await verifyOtp(otpCode.value, _session!);
      await upsertUser(cred.user!);
      status.value = AuthStatus.authenticated;
      // Navigation will be handled by auth stream listener
    } catch (e) {
      _showError(authErrorMessage(e));
    }
  }

  Future<void> onSignOut() async {
    try {
      await signOutUseCase();
      Get.snackbar('Signed out', 'You have been logged out.');
    } catch (e) {
      _showError('Failed to sign out.');
    }
  }

  void _showError(String msg) {
    errorText.value = msg;
    status.value = AuthStatus.error;
    Get.snackbar('Auth Error', msg, snackPosition: SnackPosition.BOTTOM);
  }
}
