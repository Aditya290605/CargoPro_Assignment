import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        onFinish: () {},
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Register',
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        skipTextButton: const Text(
          'Skip',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        trailing: const Text(
          'Login',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        background: [
          // Leave empty placeholders for now
          Image.asset('assets/images/wellcome.jpg'),
          Image.asset('assets/images/wellcome2.jpg'),
          Image.asset('assets/images/wellcome3.jpg'),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 420),
                const Text(
                  'Welcome to CargoPro!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Manage your app with ease across mobile & web. '
                  'Enjoy smooth onboarding and fast authentication.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 420),
                const Text(
                  'Seamless API Integration',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Perform all CRUD operations with real-time updates. '
                  'Stay connected and manage your data effortlessly.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 420),
                const Text(
                  'Get Started Now!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Login or Register to explore CargoPro. '
                  'Experience powerful tools and smooth workflows at your fingertips.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
