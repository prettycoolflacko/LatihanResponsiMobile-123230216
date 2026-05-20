import 'package:get/get.dart';
import '../services/session_service.dart';

class AuthController extends GetxController {
  // Hardcoded credentials for demo purposes
  static const String _validUsername = 'admin';
  static const String _validPassword = 'admin';

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      return false;
    }
    if (username == _validUsername && password == _validPassword) {
      await SessionService.saveLogin(username);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await SessionService.clearSession();
  }
}
