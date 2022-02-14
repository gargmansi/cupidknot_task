import 'dart:convert';

import 'package:cupidknot_task/api.dart';
import 'package:cupidknot_task/home.dart';
import 'package:cupidknot_task/login.dart';
import 'package:cupidknot_task/profile.dart';
import 'package:cupidknot_task/text_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confpass = TextEditingController();

  bool ispasswordvisible = true;
  String gender = "male";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello. \nWelcome ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                textField("First Name", "Name", firstname),
                textField("Last Name", "Name", lastname),
                textField("Enter Email", "Email", email),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 2, color: Colors.grey),
                  )),
                  child: TextFormField(
                    controller: pass,
                    obscureText: ispasswordvisible,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            print(ispasswordvisible);
                            setState(() {
                              ispasswordvisible = !ispasswordvisible;
                            });
                          },
                          child: Text(
                            "show",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Enter Password",
                        labelStyle: TextStyle(color: Colors.blue, fontSize: 20),
                        labelText: "Password",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 2, color: Colors.grey),
                  )),
                  child: TextFormField(
                    controller: confpass,
                    obscureText: ispasswordvisible,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            print(ispasswordvisible);
                            setState(() {
                              ispasswordvisible = !ispasswordvisible;
                            });
                          },
                          child: Text(
                            "show",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Confirm Password",
                        labelStyle: TextStyle(color: Colors.blue, fontSize: 20),
                        labelText: "Password",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: Text(
                    "Date of Birth",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton(
                      value: gender,
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                          value: "male",
                          child: Text(
                            "Male",
                          ),
                        ),
                        DropdownMenuItem(
                          value: "female",
                          child: Text("Female"),
                        ),
                      ],
                      onChanged: (dynamic value) {
                        setState(() {
                          gender = value;
                        });
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    dynamic body = {
                      "first_name": firstname.text,
                      "last_name": lastname.text,
                      "email": email.text,
                      "password": pass.text,
                      "password_confirmation": confpass.text,
                      "gender": gender.toUpperCase(),
                      "birth_date": "2001-1-1"
                    };
                    print(body);
                    var response = await register(body);
                    print(response.body);
                    var data = jsonDecode(response.body);
                    if (data["access_token"] == null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text("Please check your details"),
                            );
                          });
                      return;
                    }
                    var shared = await SharedPreferences.getInstance();
                    shared.setString("token", data["access_token"]);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                        (route) => false);
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: Center(child: Text("Sign up")),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ));
                        },
                        child: Text("already have an account"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
