import 'package:flutter/material.dart';
import 'package:flutter_posting_app/controllers/auth_controller.dart';
import 'package:flutter_posting_app/screens/signup_screen.dart';
import 'package:flutter_posting_app/widgets/custom_textField.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatelessWidget {
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
        ),
        body: SingleChildScrollView(
          child: Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    'Forgot Password'.toUpperCase(),
                    style: GoogleFonts.amaranth(
                        fontSize: 32, color: Color(0xFFA31103)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  CustomTextFieldWidget(
                    hintValue: 'Enter Email',
                    controller: authController.forgotPasswordEmailC,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(45),
                        primary: Color(0xFFA31103)),
                    onPressed: () async {
                      await authController.forgotPassword(
                          context, authController.forgotPasswordEmailC.text);
                    },
                    child: authController.isLoading.value
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : Text(
                            'Forgot Password',
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
