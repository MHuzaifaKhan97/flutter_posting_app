import 'package:flutter/material.dart';
import 'package:flutter_posting_app/controllers/auth_controller.dart';
import 'package:flutter_posting_app/screens/login_screen.dart';
import 'package:flutter_posting_app/widgets/custom_textField.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFA31103),
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
        body: Obx(() {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    'Register User'.toUpperCase(),
                    style: GoogleFonts.amaranth(
                        fontSize: 32, color: Color(0xFFA31103)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  SizedBox(height: 16),
                  CustomTextFieldWidget(
                    hintValue: 'Enter Email',
                    controller: authController.signUpEmailC,
                  ),
                  SizedBox(height: 16),
                  CustomTextFieldWidget(
                    hintValue: 'Enter Password',
                    controller: authController.signUpPasswordC,
                    obscureText: true,
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(45),
                        primary: Color(0xFFA31103)),
                    onPressed: () async {
                      authController.signup(
                          context,
                          authController.signUpEmailC.text,
                          authController.signUpPasswordC.text);
                    },
                    child: authController.isLoading.value
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : Text(
                            'Register',
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have account?'),
                      SizedBox(width: 2),
                      GestureDetector(
                        onTap: () => Get.off(LoginScreen()),
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Color(0xFFA31103)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }
}
