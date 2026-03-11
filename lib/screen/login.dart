import 'package:flutter/material.dart';
import 'package:quiz_mobile/screen/root.dart';
import '../models/data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoggedIn = false;
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

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == user1.username && password == user1.password) {
      setState(() {
        isLoginFailed = false;
        isLoggedIn = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful! Welcome, ${user1.nama}.')),
      );
      Navigator.pushReplacement(      // ← move it here
      context,
      MaterialPageRoute(builder: (context) => Root(nama: user1.nama)),
    );
    } else {
      setState(() {
        isLoginFailed = true;
        isLoggedIn = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed! Please check your credentials.')),
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
                              onPressed : () {
                                if (isLoggedIn) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Root(nama: user1.nama)),
                                  );
                                } else {
                                  _login();
                                }
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