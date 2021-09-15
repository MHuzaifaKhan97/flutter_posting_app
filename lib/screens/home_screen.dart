import 'package:flutter/material.dart';
import 'package:flutter_posting_app/controllers/auth_controller.dart';
import 'package:flutter_posting_app/screens/signup_screen.dart';
import 'package:flutter_posting_app/widgets/custom_textField.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
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
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.14,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(60),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => authController.logout(),
                icon: Icon(Icons.logout))
          ],
        ),
        body: Container());
  }
}
