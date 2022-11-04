// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names

import 'package:balaji_textiles/pages/loginPage.dart';
import 'package:balaji_textiles/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class changePasswordPage extends StatefulWidget {
  const changePasswordPage({super.key});

  @override
  State<changePasswordPage> createState() => _changePasswordPageState();
}

class _changePasswordPageState extends State<changePasswordPage> {
  var message;
  final Email = TextEditingController();
  final Password = TextEditingController();
  final ConfirmPassword = TextEditingController();

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("sending OTP...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void passwordChange(String email, password, confirm_password) async {
    try {
      http.Response response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.USER_CHANGE_PASSWORD),
          body: {
            'email': email,
            'password': password,
            'confirm_password': confirm_password
          });
      Map<String, dynamic> map = jsonDecode(response.body.toString());
      message = (map["message"]);
      // ignore: unrelated_type_equality_checks
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const loginPage()));
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
          color: const Color.fromARGB(99, 236, 233, 198),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset("assets/forgotPassword.png"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Forgot Password',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 60,
                width: 50,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 240),
                child: Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
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
                  // ignore: prefer_const_constructors
                  child: TextField(
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    autofocus: false,
                    controller: Email,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                      hintText: 'Enter your Email',
                      hintStyle: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 230),
                child: Text(
                  'Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: 350,
                  height: 50,
                  // ignore: prefer_const_constructors
                  child: TextField(
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    autofocus: false,
                    controller: Password,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                      hintText: 'Enter your Password',
                      hintStyle: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 160),
                child: Text(
                  'Confirm Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: 350,
                  height: 50,
                  // ignore: prefer_const_constructors
                  child: TextField(
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    autofocus: false,
                    controller: ConfirmPassword,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                      hintText: 'Enter your Confirm Password',
                      hintStyle: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                  ),
                ),
              ),
              // ignore: prefer_const_constructors

              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 30, bottom: 30),
                child: ElevatedButton(
                  onPressed: () {
                    passwordChange(
                        Email.text.toString().trim(),
                        Password.text.toString().trim(),
                        ConfirmPassword.text.toString().trim());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(237, 228, 139, 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 10),
                    // ignore: prefer_const_constructors
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
