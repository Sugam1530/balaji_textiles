// ignore_for_file: file_names, camel_case_types, void_checks

import 'dart:convert';

import 'package:balaji_textiles/pages/homePage.dart';
import 'package:balaji_textiles/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class userListPage extends StatefulWidget {
  const userListPage({super.key});

  @override
  State<userListPage> createState() => _userListPageState();
}

class _userListPageState extends State<userListPage> {
  // ignore: prefer_typing_uninitialized_variables
  var data, message;
  postUserList() async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppConstants.BASE_URL + AppConstants.USER_SEARCH),
      );
      Map<String, dynamic> map = jsonDecode(response.body.toString());
      message = (map["message"]);
      data = map["userData"];
      // ignore: unrelated_type_equality_checks
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        return data;
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
        backgroundColor: const Color.fromARGB(255, 247, 243, 206),
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Customer List",
              style: TextStyle(color: Colors.orange),
            ),
          ),
          backgroundColor: const Color.fromARGB(200, 49, 49, 49),
          elevation: 0.0,
        ),
        body: FutureBuilder(
          future: postUserList(),
          builder: (context, snapshot) {
            if (data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return InkWell(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Icon(Icons.person),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                    data[index]["name"].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const homePage(),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
