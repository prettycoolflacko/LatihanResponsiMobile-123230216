import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_mobile/controllers/auth_controller.dart';
import 'package:quiz_mobile/screen/register.dart';
import 'package:quiz_mobile/screen/root.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoginFailed = false;

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
          color: isLoginFailed ? Colors.red : Colors.blue,
          width: 2.0,
        ),
      ),
    ),
  );
}

Widget _usernameField(TextEditingController controller, bool isLoginFailed) {
  return _inputField(
    controller: controller,
    hintText: 'Username',
  );
}

Widget _passwordField(TextEditingController controller, bool isLoginFailed) {
  return _inputField(
    controller: controller,
    hintText: 'Password',
    obscureText: true,
  );
}

  Future<void> _login() async {
    final AuthController authController = Get.find<AuthController>();
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        isLoginFailed = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter username and password.')),
      );
      return;
    }

    final user = await authController.login(
      username: username,
      password: password,
    );

    if (!mounted) {
      return;
    }

    if (user != null) {
      setState(() {
        isLoginFailed = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful! Welcome, ${user.name}.')),
      );
      Get.off(() => Root(nama: user.name));
    } else {
      setState(() {
        isLoginFailed = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed! Please check your credentials.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.login),
        title: Text('Login Page',
        style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        actions: [
          Icon(Icons.phone_android),
          SizedBox(width: 10),
          Icon(Icons.email),
        ],
        backgroundColor: Colors.amberAccent,
      ),

      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/callofthenight.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Card(
                    elevation: 8,
                    child: Container(
                      width: 500,
                      padding: EdgeInsets.all(40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 40),
                          _usernameField(_usernameController, isLoginFailed),
                          SizedBox(height: 20),
                          _passwordField(_passwordController, isLoginFailed),
                          SizedBox(height: 20),
                          
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                await _login();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pinkAccent,
                              ),
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => const RegisterPage());
                                },
                                child: const Text('Register'),
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
          ),
        ],
      ),
    );
  }
}