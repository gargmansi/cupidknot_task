import 'package:cupidknot_task/login.dart';
import 'package:cupidknot_task/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  checkUser() async {
    var shared = await SharedPreferences.getInstance();
    String? token = shared.getString("token");
    if (token != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profile()));
    } else {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), checkUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Cupidknot Task"), CircularProgressIndicator()],
          ),
        ),
      )),
    );
  }
}
