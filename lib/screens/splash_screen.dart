import 'package:flutter/material.dart';
import 'package:flutter_posting_app/screens/login_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToLogin();

    super.initState();
  }

  navigateToLogin() async {
    await Future.delayed(Duration(seconds: 3));
    Get.off(LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            './assets/logo.png',
            scale: 3,
          ),
          SizedBox(height: 8),
          Text(
            'Posting App',
            style: TextStyle(fontSize: 32),
          )
        ],
      ),
    ));
  }
}
