import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_mobile/controllers/auth_controller.dart';
import 'package:quiz_mobile/screen/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isRegisterFailed = false;

  Widget _inputField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: isRegisterFailed ? Colors.red : Colors.blue,
            width: 2.0,
          ),
        ),
      ),
    );
  }

  Widget _nameField(TextEditingController controller) {
    return _inputField(
      controller: controller,
      hintText: 'Name',
    );
  }

  Widget _usernameField(TextEditingController controller) {
    return _inputField(
      controller: controller,
      hintText: 'Username',
    );
  }

  Widget _passwordField(TextEditingController controller) {
    return _inputField(
      controller: controller,
      hintText: 'Password',
      obscureText: true,
    );
  }

  Future<void> _register() async {
    final AuthController authController = Get.find<AuthController>();
    final String name = _nameController.text.trim();
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text;

    final String? error = await authController.register(
      name: name,
      username: username,
      password: password,
    );

    if (!mounted) {
      return;
    }

    if (error != null) {
      setState(() {
        isRegisterFailed = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

    setState(() {
      isRegisterFailed = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Register successful! Please log in.')),
    );
    Get.off(() => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.person_add),
        title: const Text(
          'Register Page',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        actions: const [
          Icon(Icons.phone_android),
          SizedBox(width: 10),
          Icon(Icons.email),
        ],
        backgroundColor: Colors.amberAccent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/callofthenight.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  elevation: 8,
                  child: Container(
                    width: 500,
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 40),
                        _nameField(_nameController),
                        const SizedBox(height: 20),
                        _usernameField(_usernameController),
                        const SizedBox(height: 20),
                        _passwordField(_passwordController),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              await _register();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                            ),
                            child: const Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              onPressed: () {
                                Get.off(() => const LoginPage());
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}