// ignore_for_file: sized_box_for_whitespace, camel_case_types, file_names, prefer_typing_uninitialized_variables, duplicate_ignore, library_prefixes, deprecated_member_use, use_build_context_synchronously, prefer_const_constructors, sort_child_properties_last

import 'package:balaji_textiles/pages/loginPage.dart';
import 'package:balaji_textiles/pages/myOrderPage.dart';
import 'package:balaji_textiles/pages/profilePage.dart';
import 'package:balaji_textiles/pages/settingsPage.dart';
import 'package:balaji_textiles/pages/singleItemPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:convert';

import '../utils/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

const List<String> listDropdown = <String>['Abandon', 'Blocked'];

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  var myMenuItems = <String>[
    'Settings',
    'Logout',
  ];

  int _selectedIndex = 0;
  // ignore: prefer_typing_uninitialized_variables
  var bannerList, productList;
  // ignore: prefer_typing_uninitialized_variables
  var data, dataProduct, baseUrl;
  var dataUrl;
  List<String>? dataList;
  Future getBannerList() async {
    final response = await http.get(
      Uri.parse(AppConstants.BASE_URL + AppConstants.BANNER_LIST),
    );
    bannerList = jsonDecode(response.body.toString());
    data = bannerList["userDetails"];
    dataUrl = (data as List).map((e) => e["banner_image"]).toList();
    // ignore: unused_local_variable
    dataList = (dataUrl as List)
        .map((e) => bannerList["baseUrl"] + e)
        .cast<String>()
        .toList();
    // await for (List<dynamic> i in dataUrl.toList()) {
    //   dataList?.add(bannerList["baseUrl"] + i);
    // }

    if (response.statusCode == 200) {
      return dataList;
    } else {
      return dataList;
    }
  }

  Future getProductList() async {
    final response = await http.get(
      Uri.parse(AppConstants.BASE_URL + AppConstants.PRODUCT_LIST),
    );
    productList = jsonDecode(response.body.toString());
    dataProduct = productList["userDetails"];
    baseUrl = productList["baseUrl"];

    if (response.statusCode == 200) {
      return dataProduct;
    } else {
      return dataProduct;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onSelect(item) async {
    switch (item) {
      case 'Settings':
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const settingPage(),
        ));
        break;
      case 'Logout':
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const loginPage()),
            (route) => false);
        break;
    }
  }

  String dropdownValue = listDropdown.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.yellow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                        'https://picsum.photos/seed/picsum/200/500'),
                    backgroundColor: Colors.transparent,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5, top: 15),
                    child: const Text("BALAJI Textiles"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5, top: 5),
                    child: const Text("BALAJI Textiles pvt. ltd."),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.yellow,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.profile_circled),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const profilepage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: const Text('My Order'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const myOrderPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const settingPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About Us'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help_outline_sharp),
                    title: const Text('Help & Support'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
          PopupMenuButton<String>(
              // ignore: sort_child_properties_last
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.orangeAccent,
                ),
              ),
              onSelected: onSelect,
              itemBuilder: (BuildContext context) {
                return myMenuItems.map((String choice) {
                  return PopupMenuItem<String>(
                    child: Text(choice),
                    value: choice,
                  );
                }).toList();
              }) 
        ], 
        backgroundColor: const Color.fromARGB(200, 49, 49, 49),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        child: Container(
          color: const Color.fromARGB(99, 236, 233, 198),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              FutureBuilder(
                future: getBannerList(),
                builder: (context, snapshot) {
                  if (data == null) {
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
                    return CarouselSlider(
                      options: CarouselOptions(height: 150.0),
                      items: dataList!.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image.network(
                                i,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: FutureBuilder(
                    future: getProductList(),
                    builder: (context, snapshot) {
                      if (dataProduct == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (dataProduct.length == 0) {
                        return const Center(
                          child: Text(
                            "No products are available to show",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        );
                      } else {
                        return GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 1.5),
                          ),
                          itemCount: dataProduct.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          child: Image.network(
                                            baseUrl +
                                                dataProduct[index]
                                                        ["product_image"]
                                                    .toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          dataProduct[index]["product_name"]
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => singleItemPage(
                                        text:
                                            dataProduct[index]["id"].toString(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                launch('tel://+1234567890');
              },
              icon: Image.asset(
                "assets/telephone.png",
                scale: 0.7,
              ),
            ),
            label: 'Call',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Share.share("I Miss You");
              },
              icon: Image.asset(
                "assets/share.png",
                scale: 0.7,
              ),
            ),
            label: "Share",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                launch("https://wa.me/+918017682649?text=Hello");
              },
              icon: Image.asset(
                "assets/whatsapp.png",
                scale: 0.7,
              ),
            ),
            label: 'Whatsapp',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
