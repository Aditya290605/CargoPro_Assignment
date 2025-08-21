// presentation/routes/app_pages.dart
import 'package:cargox/core/onboarding/onboarding_screen.dart';
import 'package:cargox/features/auth/presentation/screens/home_screen.dart';
import 'package:cargox/features/auth/presentation/screens/otp_screen.dart';
import 'package:cargox/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.login, page: () => const SignUpScreen()),
    GetPage(name: Routes.otp, page: () => const OtpScreen()),
    GetPage(name: Routes.home, page: () => const HomeView()),
    GetPage(name: Routes.onboarding, page: () => OnBoardingScreen()),
  ];
}

// presentation/routes/app_routes.dart

class Routes {
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const otp = '/otp';
  static const home = '/home';
}
