// ignore_for_file: file_names, camel_case_types, use_build_context_synchronously

import 'package:balaji_textiles/pages/loginPage.dart';
import 'package:balaji_textiles/pages/privacyPolicyPage.dart';
import 'package:balaji_textiles/pages/termsAndConditionPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settingPage extends StatefulWidget {
  const settingPage({super.key});

  @override
  State<settingPage> createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 243, 206),
      body: Container(
        margin: const EdgeInsets.only(right: 5, top: 50, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const Text('Terms & Condition'),
                const SizedBox(
                  width: 170,
                ),
                Radio(
                  value: 2,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value!;
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const termsAndconditionPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text('Privacy Policy'),
                const SizedBox(
                  width: 200,
                ),
                Radio(
                  value: 1,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value!;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const privacyPolicyPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text('Logout'),
                const SizedBox(
                  width: 242,
                ),
                Radio(
                  //fillColor: MaterialStatePropertyAll(Colors.black),
                  value: 3,
                  groupValue: _value,
                  onChanged: (value) async {
                    setState(() {
                      _value = value!;
                    });
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await preferences.clear();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const loginPage()),
                        (route) => false);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
