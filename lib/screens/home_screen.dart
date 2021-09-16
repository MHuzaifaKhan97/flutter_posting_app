import 'package:flutter/material.dart';
import 'package:flutter_posting_app/controllers/auth_controller.dart';
import 'package:flutter_posting_app/screens/signup_screen.dart';
import 'package:flutter_posting_app/widgets/custom_textField.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      './assets/logo.png',
                      scale: 12,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Posting App'.toUpperCase(),
                      style: GoogleFonts.amaranth(fontSize: 26),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // ignore: unrelated_type_equality_checks
                // authController.isUserVerified == true
                //     ? Container()
                //     : Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             'You email is not verified',
                //             style: TextStyle(
                //                 fontSize: 14, color: Colors.orange[400]),
                //           ),
                //           SizedBox(width: 4),
                //           GestureDetector(
                //             onTap: () {
                //               authController.sendEmailVerification();
                //               setState(() {});
                //             },
                //             child: Text(
                //               'Verify Email',
                //               style: TextStyle(
                //                   fontSize: 14,
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.bold,
                //                   decoration: TextDecoration.underline),
                //             ),
                //           ),
                //         ],
                //       )
              ],
            ),
            centerTitle: true,
            toolbarHeight: MediaQuery.of(context).size.height * 0.14,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () => authController.logout(),
                  icon: Icon(Icons.logout)),
              SizedBox(width: 8)
            ],
          ),
          body: Container()),
    );
  }
}
