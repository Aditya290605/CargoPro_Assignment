// core/di/app_bindings.dart
import 'package:cargox/features/auth/data/datascource/datasource.dart';
import 'package:cargox/features/auth/data/repository/reposiotry_impl.dart';
import 'package:cargox/features/auth/domain/repository/auth_repsitory.dart';
import 'package:cargox/features/auth/domain/usecase/auth_usecase.dart';
import 'package:cargox/features/auth/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    final auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    final src = FirebaseAuthSource(auth, db);
    final repo = AuthRepositoryImpl(src);

    Get.put<AuthRepository>(repo, permanent: true);
    Get.put(SendOtp(repo), permanent: true);
    Get.put(VerifyOtp(repo), permanent: true);
    Get.put(UpsertUser(repo), permanent: true);
    Get.put(AuthStateStream(repo), permanent: true);
    Get.put(SignOut(repo), permanent: true);

    Get.put(
      AuthController(
        sendOtp: Get.find(),
        verifyOtp: Get.find(),
        upsertUser: Get.find(),
        authStateStream: Get.find(),
        signOutUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
