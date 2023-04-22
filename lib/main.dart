import 'package:benyiino_shop/screens/Home/HomeScreen.dart';
import 'package:benyiino_shop/screens/Login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Benyiino Shop',
      theme: ThemeData.light().copyWith(
        primaryColor: const Color.fromRGBO(254, 0, 22, 1),
        colorScheme: ThemeData.light().colorScheme.copyWith(
              primary: const Color.fromRGBO(254, 0, 22, 1),
              secondary: const Color.fromRGBO(254, 0, 22, 1),
            ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: const Color.fromRGBO(254, 0, 22, 1),
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: const Color.fromRGBO(254, 0, 22, 1),
              secondary: const Color.fromRGBO(254, 0, 22, 1),
            ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
