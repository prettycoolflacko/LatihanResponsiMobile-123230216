import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_mobile/controllers/auth_controller.dart';
import 'package:quiz_mobile/screen/login.dart';
import 'package:quiz_mobile/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();
  Get.put(AuthController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}
