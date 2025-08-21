import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class HomeView extends GetView<AuthController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: ctrl.onSignOut, icon: const Icon(Icons.logout)),
        ],
      ),
      body: const Center(
        child: Text('Logged in! (continue with your CRUD views)'),
      ),
    );
  }
}
