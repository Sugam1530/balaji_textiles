// ignore_for_file: file_names, camel_case_types, sized_box_for_whitespace, use_build_context_synchronously

import 'package:balaji_textiles/pages/homePage.dart';
import 'package:balaji_textiles/pages/loginPage.dart';
import 'package:balaji_textiles/pages/userListPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashScreenPage extends StatefulWidget {
  const splashScreenPage({super.key});

  @override
  State<splashScreenPage> createState() => _splashScreenPageState();
}

class _splashScreenPageState extends State<splashScreenPage> {
  @override
  void initState() {
    super.initState();
    _navigatehome();
  }

  _navigatehome() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    String? type = sharedPreferences.getString('type');

    if (token != null) {
      await Future.delayed(const Duration(milliseconds: 1500), () {});
      if (type == "employee") {
        Navigator.pushReplacement(
            (context),
            MaterialPageRoute(
              builder: (context) => const userListPage(),
            ));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const homePage(),
          ),
        );
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 1500), () {});
      Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) => const loginPage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          "assets/splashScreen.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
