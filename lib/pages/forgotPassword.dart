// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'package:balaji_textiles/pages/confirmForgetPassword.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/app_constants.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  String? message;
  final Email = TextEditingController();

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

  void sendOTP(String email) async {
    try {
      http.Response response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.USER_FORGET_PASSWORD),
          body: {
            'email': email,
          });
      Map<String, dynamic> map = jsonDecode(response.body.toString());
      message = (map["message"]);
      // ignore: unrelated_type_equality_checks
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const confirmForgetPassword()));
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
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 240),
                      child: Text(
                        'Email',
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
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      showLoaderDialog(context);
                      sendOTP(Email.text.toString().trim());
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
      ),
    );
  }
}
