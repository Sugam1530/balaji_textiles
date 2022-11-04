// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_typing_uninitialized_variables, file_names

import 'dart:convert';

import 'package:balaji_textiles/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class privacyPolicyPage extends StatefulWidget {
  const privacyPolicyPage({super.key});

  @override
  State<privacyPolicyPage> createState() => _privacyPolicyPageState();
}

class _privacyPolicyPageState extends State<privacyPolicyPage> {
  var data;
  Future getPrivacyPolicy() async {
    final response = await http.get(
          Uri.parse(AppConstants.BASE_URL + AppConstants.PRIVACY_POLICY),
        ),
        map = jsonDecode(response.body.toString());
    data = map["list"];

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 243, 206),
      body: FutureBuilder(
        future: getPrivacyPolicy(),
        builder: (context, snapshot) {
          if (data == null) {
            return Center(
              child: const CircularProgressIndicator(),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(top: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Center(
                    child: Text(
                      "Privacy Policy",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 10),
                    child: Text(
                      data[0]["privacy_policy"].toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
