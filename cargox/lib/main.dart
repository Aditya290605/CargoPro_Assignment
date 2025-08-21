// main.dart
import 'package:cargox/core/utils/app_bindings.dart';
import 'package:cargox/features/auth/presentation/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(
    GetMaterialApp(
      title: 'CargoX',
      initialBinding: InitialBinding(),
      initialRoute: Routes.onboarding,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
    ),
  );
}
