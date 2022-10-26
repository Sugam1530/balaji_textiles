// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:balaji_textiles/pages/forgotPassword.dart';
import 'package:balaji_textiles/pages/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/app_constants.dart';

// ignore: camel_case_types
class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

// ignore: camel_case_types
class _loginPageState extends State<loginPage> {
  String? message;
  // ignore: non_constant_identifier_names
  final Phone = TextEditingController();
  // ignore: non_constant_identifier_names
  final Password = TextEditingController();
  void login(String phone, password) async {
    try {
      http.Response response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.USER_LOGIN),
          body: {
            'phone': phone,
            'password': password,
          });
      Map<String, dynamic> map = jsonDecode(response.body.toString());
      message = (map["message"]);
      // ignore: unrelated_type_equality_checks
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const loginPage()));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message.toString()),
        ));
      }
    } catch (e) {
      // ignore: avoid_print
      print(Exception(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        // ignore: sized_box_for_whitespace
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Material(
            color: const Color.fromARGB(99, 236, 233, 198),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/login.png'),
                  backgroundColor: Color.fromARGB(99, 236, 233, 198),
                ),
                const Text(
                  'Log in',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 60,
                  width: 50,
                ),
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 180),
                      child: Text(
                        'Mobile number',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: 350,
                    height: 50,
                    child: TextField(
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      controller: Phone,
                      autofocus: false,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        hintText: 'Enter your mobile number',
                        hintStyle: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 220, top: 15),
                      child: Text(
                        'Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: 350,
                    height: 50,
                    child: TextField(
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      obscureText: true,
                      controller: Password,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      login(Phone.text.toString().trim(),
                          Password.text.toString().trim());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(237, 228, 139, 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 10),
                      // ignore: prefer_const_constructors
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    child: const Text("Log in"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 210, top: 20),
                  child: InkWell(
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const forgotPassword()),
                      );
                    },
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      "Don't have account?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      // ignore: prefer_const_constructors
                      child: Text(
                        "Register",
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const registerPage()));
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
