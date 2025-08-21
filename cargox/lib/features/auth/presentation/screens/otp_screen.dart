import 'package:cargox/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final ctrl = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 15),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Verify your OTP",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "verification code has been sent",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(height: 20),
                Pinput(onChanged: (v) => ctrl.otpCode.value = v.trim()),
                const SizedBox(height: 20),
                Text(
                  'Did\'t get the code ?',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),

                Text(
                  "Rsend code",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Colors.blue),
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: ctrl.status.value == AuthStatus.verifying
                      ? null
                      : () {
                          ctrl.onVerifyCode();
                        },
                  child: ctrl.status.value == AuthStatus.verifying
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Verify & Continue'),
                ),

                if (ctrl.errorText.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    ctrl.errorText.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
