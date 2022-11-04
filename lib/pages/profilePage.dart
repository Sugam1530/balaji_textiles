// ignore_for_file: file_names, camel_case_types, deprecated_member_use, sized_box_for_whitespace, duplicate_ignore, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:io';

import 'package:balaji_textiles/pages/homePage.dart';
import 'package:balaji_textiles/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shimmer/shimmer.dart';

class profilepage extends StatefulWidget {
  const profilepage({super.key});

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  var data, message;

  final Name = TextEditingController();
  final Email = TextEditingController();
  final Phone = TextEditingController();
  final WPNumber = TextEditingController();
  final Address = TextEditingController();

  void editSave(String name, phone, email, address, wpnumber) async {
    try {
      http.Response response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.USER_SIGNUP),
          body: {
            'name': name,
            'phone': phone,
            'email': email,
            'address': address,
            'wpnumber': wpnumber,
          });
      Map<String, dynamic> map = jsonDecode(response.body.toString());
      message = (map["message"]);
      // ignore: unrelated_type_equality_checks
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const homePage()));
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

  Future getProfileApi() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    final response = await http.get(
        Uri.parse(AppConstants.BASE_URL + AppConstants.USER_DETAILS),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        });

    Map<String, dynamic> map = jsonDecode(response.body.toString());
    data = map["userDetails"];

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.orangeAccent),
        title: Center(
          child: IconButton(
            iconSize: 100,
            onPressed: () {},
            icon: Image.asset("assets/mainIcon.png"),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.orangeAccent,
            ),
            tooltip: 'Setting Icon',
            onPressed: () {},
          ), //IconButton
        ], //<Widget>[]
        backgroundColor: const Color.fromARGB(200, 49, 49, 49),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        child: FutureBuilder(
          future: getProfileApi(),
          builder: (context, snapshot) {
            if (data == null) {
              // ignore: prefer_const_constructors
              return Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 6.0, bottom: 4.0, left: 20.0, right: 20.0),
                      child: SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Colors.black38,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container(
                color: const Color.fromARGB(99, 236, 233, 198),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Edit Profile",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage("assets/profile.png"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Change Image",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Full Name",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        // ignore: sized_box_for_whitespace
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 200,
                            height: 40,
                            color: const Color.fromARGB(255, 177, 219, 238),
                            child: TextField(
                              textAlign: TextAlign.center,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              autofocus: false,
                              controller: Name,
                              decoration: InputDecoration(
                                hintText: data["name"].toString(),
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 15),
                                focusedBorder: const OutlineInputBorder(),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 70,
                          child: const Text(
                            "Email Id",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        // ignore: sized_box_for_whitespace
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 200,
                            height: 40,
                            color: const Color.fromARGB(255, 177, 219, 238),
                            child: TextField(
                              textAlign: TextAlign.center,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              autofocus: false,
                              controller: Email,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 15),
                                focusedBorder: const OutlineInputBorder(),
                                border: const OutlineInputBorder(),
                                hintText: data["email"].toString(),
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 70,
                          child: const Text(
                            "Mobile Number",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        // ignore: sized_box_for_whitespace
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 200,
                            height: 40,
                            color: const Color.fromARGB(255, 177, 219, 238),
                            child: TextField(
                              textAlign: TextAlign.center,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              autofocus: false,
                              controller: Phone,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 15),
                                focusedBorder: const OutlineInputBorder(),
                                border: const OutlineInputBorder(),
                                hintText: data["phone"].toString(),
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 85,
                          child: const Text(
                            "WhatsApp Number",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          width: 27,
                        ),
                        // ignore: sized_box_for_whitespace
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 200,
                            height: 40,
                            color: const Color.fromARGB(255, 177, 219, 238),
                            child: TextField(
                              textAlign: TextAlign.center,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              autofocus: false,
                              controller: WPNumber,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 15),
                                focusedBorder: const OutlineInputBorder(),
                                border: const OutlineInputBorder(),
                                hintText: (data["wp_number"] == null)
                                    ? " "
                                    : data["wp_number"].toString(),
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 85,
                          child: const Text(
                            "Address",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          width: 27,
                        ),
                        // ignore: sized_box_for_whitespace
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 200,
                            height: 150,
                            color: const Color.fromARGB(255, 177, 219, 238),
                            child: TextField(
                              textAlign: TextAlign.center,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              minLines: 1,
                              maxLines: 6,
                              autofocus: false,
                              controller: Address,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 15),
                                border: InputBorder.none,
                                hintText: data["address"].toString(),
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        editSave(
                            Name.text.toString().trim(),
                            Phone.text.toString().trim(),
                            Email.text.toString().trim(),
                            Address.text.toString().trim(),
                            WPNumber.text.toString().trim());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 247, 156, 19),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 55, vertical: 5),
                      ),
                      child: const Text("Save"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
