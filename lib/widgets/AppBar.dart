import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    this.title = 'Benyiino Shop',
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          const BackButton(color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: () => Get.changeThemeMode(
              Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
            ),
            icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode, color: Colors.white),
          )
        ],
      ),
    );
  }
}
