// ignore_for_file: non_constant_identifier_names, duplicate_ignore, file_names, sized_box_for_whitespace


import 'package:balaji_textiles/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/app_constants.dart';

// ignore: camel_case_types
class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

// ignore: camel_case_types
class _registerPageState extends State<registerPage> {
  // ignore: prefer_typing_uninitialized_variables
  var message;

  final Name = TextEditingController();
  final Email = TextEditingController();
  final Phone = TextEditingController();
  final Password = TextEditingController();
  final User = TextEditingController();
  final Address = TextEditingController();

  void register(String name, email, phone, password, user, address) async {
    try {
      http.Response response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.USER_SIGNUP),
          body: {
            'name': name,
            'email': email,
            'phone': phone,
            'password': password,
            'user_type': user,
            'address': address,
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
    bool isChecked = true;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(99, 236, 233, 198),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Image.asset("assets/registration.png"),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 25,
              ),
              const Text(
                "Registration and Verification",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                // ignore: prefer_const_constructors
                margin: EdgeInsets.only(
                  right: 200,
                ),
                // ignore: prefer_const_constructors
                child: Text(
                  "Phone Number:",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 30,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text("IN  +91"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 225,
                    height: 40,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: Phone,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      autofocus: false,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        hintText: 'Enter your Phone Number',
                        hintStyle: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 25,
              ),
              Container(
                // ignore: prefer_const_constructors
                margin: EdgeInsets.only(
                  right: 230,
                ),
                // ignore: prefer_const_constructors
                child: Text(
                  "Full Name*:",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 300,
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: Name,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    hintText: 'Enter your Full Name',
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 25,
              ),
              Container(
                // ignore: prefer_const_constructors
                margin: EdgeInsets.only(
                  right: 250,
                ),
                // ignore: prefer_const_constructors
                child: Text(
                  "Address:",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 300,
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: Address,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    hintText: 'Enter your Address',
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 25,
              ),
              Container(
                // ignore: prefer_const_constructors
                margin: EdgeInsets.only(
                  right: 260,
                ),
                // ignore: prefer_const_constructors
                child: Text(
                  "EMail*:",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 300,
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
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
              const SizedBox(
                height: 25,
              ),
              Container(
                // ignore: prefer_const_constructors
                margin: EdgeInsets.only(
                  right: 230,
                ),
                // ignore: prefer_const_constructors
                child: Text(
                  "Password*:",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 300,
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: Password,
                  obscureText: isChecked,
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
              // ignore: prefer_const_constructors
              SizedBox(
                height: 5,
              ),
              // ignore: prefer_const_constructors
              Container(
                margin: const EdgeInsets.only(right: 150),
                // ignore: prefer_const_constructors
                child: Text(
                  "*Must be atleast 6 characters",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const Text('for Further log in process'),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  register(
                      Name.text.toString().trim(),
                      Email.text.toString().trim(),
                      Phone.text.toString().trim(),
                      Password.text.toString().trim(),
                      "user",
                      Address.text.toString().trim());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 214, 152, 59),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  // ignore: prefer_const_constructors
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                child: const Text("Register"),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "Have already account?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    // ignore: prefer_const_constructors
                    child: Text(
                      "Login",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const loginPage()));
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
    );
  }
}
