import 'package:flutter/material.dart';

class confirmForgetPassword extends StatefulWidget {
  const confirmForgetPassword({super.key});

  @override
  State<confirmForgetPassword> createState() => _confirmForgetPasswordState();
}

class _confirmForgetPasswordState extends State<confirmForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        // ignore: sized_box_for_whitespace
        child: Container(
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
                const Padding(
                  padding: EdgeInsets.only(right: 240),
                  child: Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
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
                    // ignore: prefer_const_constructors
                    child: TextField(
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
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
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 260),
                  child: Text(
                    'OTP',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: 350,
                    height: 50,
                    // ignore: prefer_const_constructors
                    child: TextField(
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        hintText: 'Enter your OTP',
                        hintStyle: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 220),
                  child: Text(
                    'Password*',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: 350,
                    height: 50,
                    // ignore: prefer_const_constructors
                    child: TextField(
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        hintText: 'Enter your new Password',
                        hintStyle: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                Container(
                  margin: const EdgeInsets.only(right: 130),
                  child: const Text("*Must be atleast 6 characters"),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 150),
                  child: Text(
                    'Confirm Password*',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: 350,
                    height: 50,
                    // ignore: prefer_const_constructors
                    child: TextField(
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Confirm Password',
                        hintStyle: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      
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
