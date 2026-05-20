import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_mobile/controllers/auth_controller.dart';
import 'package:quiz_mobile/screen/login.dart';
import 'package:quiz_mobile/screen/root.dart';
import 'package:quiz_mobile/services/session_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());

  // Check for existing session
  final bool loggedIn = await SessionService.isLoggedIn();

  runApp(MainApp(isLoggedIn: loggedIn));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;

  const MainApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: isLoggedIn ? const Root() : const LoginPage(),
    );
  }
}
