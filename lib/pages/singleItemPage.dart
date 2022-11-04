// ignore_for_file: sort_child_properties_last, prefer_const_constructors, duplicate_ignore, camel_case_types, file_names

import 'dart:convert';
import 'dart:io';

import 'package:balaji_textiles/pages/myOrderPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/app_constants.dart';

class singleItemPage extends StatefulWidget {
  final String text;
  const singleItemPage({Key? key, required this.text}) : super(key: key);

  @override
  State<singleItemPage> createState() => _singleItemPageState();
}

class _singleItemPageState extends State<singleItemPage> {
  late String sugam = widget.text;
  // ignore: prefer_typing_uninitialized_variables
  var data, baseUrl, message, data1;
  Future productDetails(String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    // ignore: prefer_interpolation_to_compose_strings
    final uri = Uri.parse(
        "${AppConstants.BASE_URL}${AppConstants.PRODUCT_DETAILS}?id=$sugam");

    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });

    Map<String, dynamic> map = jsonDecode(response.body.toString());
    data = map["userDetails"];
    baseUrl = map["baseUrl"];

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  void addToCart(String productId, orderQuantity, userId) async {
    try {
      http.Response response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.ADD_TO_CART),
          body: {
            'product_id': productId,
            'order_quantity': orderQuantity,
            'user_id': userId
          });
      Map<String, dynamic> map = jsonDecode(response.body.toString());
      message = (map["message"]);
      // ignore: unrelated_type_equality_checks
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Item has added to cart successfully"),
        ));
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
    data1 = map["userDetails"];

    if (response.statusCode == 200) {
      return data1;
    } else {
      return data1;
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
      body: Container(
        color: const Color.fromARGB(99, 236, 233, 198),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          child: FutureBuilder(
            future: getProfileApi(),
            builder: (context, snapshot) {
              if (data1 == null) {
                return Center(
                  child: const CircularProgressIndicator(),
                );
              } else {
                return FutureBuilder(
                  future: productDetails(sugam),
                  builder: (context, snapshot) {
                    if (data == null) {
                      // ignore: prefer_const_constructors
                      return Center(
                        child: const CircularProgressIndicator(),
                      );
                    } else {
                      return Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  child: (Icon(
                                    Icons.shopping_cart,
                                    size: 35,
                                  )),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const myOrderPage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Image.network(
                                baseUrl + data["product_image"],
                                fit: BoxFit.cover,
                              ),
                              height: 300,
                              width: 400,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Text(
                                    data["product_name"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    right: 20,
                                  ),
                                  child: Text(
                                    '₹ ${data["product_price"]}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                right: 130,
                              ),
                              child: Column(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    'Available Product: ${data["product_alert"]}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                right: 190,
                              ),
                              child: Column(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      data["product_desc"].toString(),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ]),
                            ),
                            // ignore: prefer_const_constructors
                            SizedBox(height: 30.0),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 108.0),
                              child: SizedBox(
                                height: 50,
                                width: 230,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orangeAccent),
                                  child: const Text('Add to cart'),
                                  onPressed: () {
                                    addToCart(
                                        sugam, "1", data1["id"].toString());
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
