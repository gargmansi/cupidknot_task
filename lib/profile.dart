import 'dart:ui';

import 'package:cupidknot_task/api.dart';
import 'package:cupidknot_task/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: profile(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                snapshot.data["name"],
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 25),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data["email"],
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border:
                                  Border.all(width: 1.0, color: Colors.white)),
                          child: Text(
                            snapshot.data["gender"],
                            style: TextStyle(fontSize: 25),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border:
                                  Border.all(width: 1.0, color: Colors.white)),
                          child: Text(
                            snapshot.data["birth_date"],
                            style: TextStyle(fontSize: 25),
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var shared = await SharedPreferences.getInstance();
                          shared.clear();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                              (route) => false);
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          child: Center(child: Text("Log Out")),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
