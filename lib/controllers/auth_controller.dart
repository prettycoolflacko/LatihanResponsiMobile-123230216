import 'package:get/get.dart';
import '../models/user_database.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final UserDatabase _db = UserDatabase.instance;

  Future<UserModel?> login({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      return null;
    }
    return _db.validateUser(username, password);
  }

  Future<String?> register({
    required String name,
    required String username,
    required String password,
  }) async {
    if (name.isEmpty || username.isEmpty || password.isEmpty) {
      return 'Please complete all fields.';
    }
    final bool exists = await _db.usernameExists(username);
    if (exists) {
      return 'Username already exists.';
    }
    try {
      await _db.insertUser(
        UserModel(
          name: name,
          username: username,
          password: password,
        ),
      );
    } catch (_) {
      return 'Failed to register. Please try again.';
    }
    return null;
  }
}
