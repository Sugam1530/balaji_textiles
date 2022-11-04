// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_typing_uninitialized_variables, file_names

import 'dart:convert';

import 'package:balaji_textiles/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class termsAndconditionPage extends StatefulWidget {
  const termsAndconditionPage({super.key});

  @override
  State<termsAndconditionPage> createState() => _termsAndconditionPageState();
}

class _termsAndconditionPageState extends State<termsAndconditionPage> {
  var data;
  Future getTermsAndConditions() async {
    final response = await http.get(
          Uri.parse(AppConstants.BASE_URL + AppConstants.TERMS_CONDITIONS),
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
        future: getTermsAndConditions(),
        builder: (context, snapshot) {
          if (data == null) {
            return Center(
              child: const CircularProgressIndicator(),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(top: 60),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Center(
                    child: Text(
                      "Terms & Conditions",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    data[0]["content"].toString(),
                    style: TextStyle(fontSize: 20),
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
