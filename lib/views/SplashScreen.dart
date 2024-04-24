import 'dart:async';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => {
              // if (isLogin)
              //   {
              //     Navigator.pushReplacement(context,
              //         MaterialPageRoute(builder: (context) => DashBoardScreen()))
              //   }
              // else
              //   {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()))
              // }
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
}
