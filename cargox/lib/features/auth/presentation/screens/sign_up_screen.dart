import 'package:cargox/features/auth/presentation/controllers/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ctrl = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.png',
            width: double.infinity,
            fit: BoxFit.fitHeight,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              height: MediaQuery.of(context).size.height * 0.75,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CargoX",
                      style: Theme.of(context).textTheme.headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Hello ! Welcome to CargoX ",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Create your account",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "Enter you number",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        maxLines: 1,
                        initialValue: '+91',
                        keyboardType: TextInputType.phone,
                        onChanged: (v) => ctrl.phone.value = v.trim(),
                        validator: (_) => ctrl.errorText.value.isEmpty
                            ? null
                            : ctrl.errorText.value,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: ctrl.status.value == AuthStatus.sendingOtp
                            ? null
                            : () {
                                ctrl.onSendOtp();
                              },
                        child: ctrl.status.value == AuthStatus.sendingOtp
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Send OTP'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
