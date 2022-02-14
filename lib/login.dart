import 'dart:convert';

import 'package:cupidknot_task/api.dart';
import 'package:cupidknot_task/profile.dart';
import 'package:cupidknot_task/register.dart';
import 'package:cupidknot_task/text_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool ispasswordvisible = true;
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
                  "Hello. \nWelcome Back",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                textField("User Email", "Email", name),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 2, color: Colors.grey)),
                  ),
                  child: TextFormField(
                    controller: pass,
                    obscureText: ispasswordvisible,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              ispasswordvisible = !ispasswordvisible;
                            });
                          },
                          child: Text(
                            "Show",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        hintText: "Enter password",
                        labelStyle: TextStyle(color: Colors.blue),
                        labelText: "Password"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    dynamic body = {
                      "username": name.text,
                      "password": pass.text,
                    };
                    var response = await login(body);
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
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("Login")),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ));
                        },
                        child: Text("Create an account"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
