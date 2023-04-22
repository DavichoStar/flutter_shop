import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          color: Colors.blue,
          child: const Text('Home', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
