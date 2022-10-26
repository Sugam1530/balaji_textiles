
// ignore_for_file: unused_import, duplicate_ignore

import 'package:balaji_textiles/pages/loginPage.dart';
// ignore: unused_import
import 'package:balaji_textiles/pages/registerPage.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp( const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Balaji Textile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const registerPage(), 
    );
  }
}
