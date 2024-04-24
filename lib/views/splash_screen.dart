import 'dart:async';
import 'package:flutter/material.dart';
import '../other/constants.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  var isLogin = false;

  @override
  void initState() {
    super.initState();
    getValueFromPref();
    Timer(
        const Duration(seconds: 2),
        () {
              if (isLogin)
                {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => DashBoardScreen()));
                } else
                {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
              };
            });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('e-Commerce', style: TextStyle(fontSize: 20, color: Colors.blue)),
      ),
    );
  }

  void getValueFromPref() async {
    var pref = await SharedPreferences.getInstance();
    isLogin = pref.getBool(Constants.IS_LOGIN) ?? false;
  }
}
