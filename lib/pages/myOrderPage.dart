// ignore_for_file: avoid_unnecessary_containers, file_names, camel_case_types, non_constant_identifier_names, sized_box_for_whitespace, use_build_context_synchronously, avoid_print, duplicate_ignore

// ignore: unused_import
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:balaji_textiles/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../utils/app_constants.dart';

class myOrderPage extends StatefulWidget {
  const myOrderPage({super.key});

  @override
  State<myOrderPage> createState() => _myOrderPageState();
}

class _myOrderPageState extends State<myOrderPage> {
  // ignore: prefer_typing_uninitialized_variables
  var data, message, baseUrl, price, quantity = 0, quantity1 = 0, flag = 0;
  List? data1;
  List<int>? cartCount = [1];
  List<int>? idList = [1];

  var currentDate = DateTime(
          DateTime.fromMillisecondsSinceEpoch(
                  DateTime.now().millisecondsSinceEpoch)
              .year,
          DateTime.fromMillisecondsSinceEpoch(
                  DateTime.now().millisecondsSinceEpoch)
              .month,
          DateTime.fromMillisecondsSinceEpoch(
                  DateTime.now().millisecondsSinceEpoch)
              .day)
      .toString()
      .replaceAll(" 00:00:00.000", "").split('-').reversed.join('-');

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

  cardList(String user_id) async {
    try {
      http.Response response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.CARD_LIST),
          body: {
            'user_id': user_id,
          });
      Map<String, dynamic> map = jsonDecode(response.body.toString());
      message = (map["message"]);
      data1 = map["data"];
      baseUrl = map["baseUrl"];
      price = map["total_price"];
      if (quantity < 1) {
        for (var i = 1; i <= data1!.length; i++) {
          cartCount?.add(1);
        }
      }
      quantity++;
      flag = 0;
      // ignore: unrelated_type_equality_checks
      if (response.statusCode == 200) {
        if (quantity1 == 0) {
          for (var i = 0; i < data1!.length; i++) {
            idList?.add(data1![i]["id"]);
          }
          idList?.removeAt(0);
        }

        quantity1++;
        // ignore: use_build_context_synchronously
        return data1;
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

  void postCartConfirm(String user_id, product_id, order_quantity, date) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    String? message;
    try {
      http.Response response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.CART_CONFIRM_ORDER),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: {
            'user_id': user_id,
            'product_id': product_id,
            'order_quantity': order_quantity,
            'date': date
          });
      Map<String, dynamic> map = jsonDecode(response.body.toString());
      message = (map["message"]);
      if (response.statusCode == 200) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const homePage(),
        ));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message.toString()),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message.toString()),
        ));
      }
    } catch (e) {
      print(Exception(e.toString()));
    }
  }

  void cardRemove(String card_id) async {
    String? message;
    try {
      http.Response response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.CARD_REMOVE),
          body: {
            'card_id': card_id,
          });
      Map<String, dynamic> map = jsonDecode(response.body.toString());
      message = (map["message"]);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message.toString()),
        ));
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message.toString()),
        ));
      }
    } catch (e) {
      print(Exception(e.toString()));
    }
  }

  cardFix(String id, int i) {
    cardRemove(id);
    if (flag == 0) {
      data1!.removeAt(i - 1);
      cartCount!.removeAt(i);
      //flag = 1;
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
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
          physics: const ClampingScrollPhysics(),
          child: Container(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(
                  height: 40,
                ),
                // ignore: prefer_const_constructors
                Align(
                  alignment: Alignment.center,
                  child: const Text(
                    "My Order",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: FutureBuilder(
                    future: getProfileApi(),
                    builder: (context, snapshot) {
                      if (data == null) {
                        return Container(
                          color: const Color.fromARGB(99, 236, 233, 198),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 6.0,
                                    bottom: 4.0,
                                    left: 20.0,
                                    right: 20.0),
                                child: SizedBox(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor: Colors.black38,
                                    child: Container(
                                      color: const Color.fromARGB(
                                          99, 236, 233, 198),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return FutureBuilder(
                          future: cardList(data["id"].toString()),
                          builder: (context, snapshot) {
                            if (data1 == null) {
                              return Container(
                                color: Colors.white,
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 6.0,
                                          bottom: 4.0,
                                          left: 20.0,
                                          right: 20.0),
                                      child: SizedBox(
                                        height: 150,
                                        width:
                                            MediaQuery.of(context).size.width,
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
                            } else if (data1!.isEmpty) {
                              return const Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 180.0, bottom: 290),
                                  child: Text(
                                    "Your cart is empty",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                height: (data1!.length <= 4) ? 500 : null,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data1!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: const Color.fromARGB(
                                            54, 64, 195, 255),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                baseUrl +
                                                    ((index < data1!.length)
                                                        ? data1![index][
                                                                "product_image"]
                                                            .toString()
                                                        : ""),
                                                height: 80,
                                                width: 80,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: 65,
                                                margin: const EdgeInsets.only(
                                                    left: 8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data1![index]
                                                              ["product_name"]
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text(
                                                      (index < data1!.length)
                                                          ? "Rs. ${data1![index]["total_price"]}"
                                                          : "",
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 50),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    child: Image.asset(
                                                      "assets/remove.png",
                                                      height: 15,
                                                      width: 15,
                                                    ),
                                                    onTap: () {
                                                      (index ==
                                                              cartCount?.length)
                                                          ? null
                                                          : cartCount?[
                                                              (index + 1)]--;

                                                      if (cartCount![
                                                              (index + 1)] <=
                                                          0) {
                                                        cardFix(
                                                            data1![index]["id"]
                                                                .toString(),
                                                            (index + 1));
                                                      }
                                                      setState(() {});
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              (cartCount == null)
                                                  ? ((index ==
                                                          cartCount?.length)
                                                      ? ""
                                                      : "1")
                                                  : cartCount![(index + 1)]
                                                      .toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              child: Image.asset(
                                                "assets/add.png",
                                                height: 15,
                                                width: 15,
                                              ),
                                              onTap: () {
                                                cartCount?[(index + 1)]++;
                                                setState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
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
              return FutureBuilder(
                future: cardList(data["id"].toString()),
                builder: (context, snapshot) {
                  if (data1 == null) {
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
                    return InkWell(
                      child: Container(
                        height: 60,
                        color: Colors.orange,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: const Text(
                                'Confirm Order',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: Text(
                                "Rs. $price",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        showLoaderDialog(context);
                        postCartConfirm(
                            data["id"].toString(),
                            idList.toString(),
                            cartCount.toString(),
                            currentDate.toString());
                      },
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
