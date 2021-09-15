import 'package:flutter/material.dart';
import 'package:flutter_posting_app/controllers/auth_controller.dart';
import 'package:flutter_posting_app/screens/signup_screen.dart';
import 'package:flutter_posting_app/widgets/custom_textField.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                'Login'.toUpperCase(),
                style: GoogleFonts.amaranth(
                    fontSize: 40, color: Color(0xFFA31103)),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              CustomTextFieldWidget(
                hintValue: 'Enter Email',
                controller: authController.loginEmailC,
              ),
              SizedBox(height: 16),
              CustomTextFieldWidget(
                hintValue: 'Enter Password',
                controller: authController.loginPasswordC,
                obscureText: true,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {},
                      // onPressed: () => Get.off(ForgotPasswordScreen()),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: Color(0xFFA31103),
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(45),
                    primary: Color(0xFFA31103)),
                onPressed: () async {
                  await authController.login(
                      context,
                      authController.loginEmailC.text,
                      authController.loginPasswordC.text);
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have account?'),
                  SizedBox(width: 2),
                  GestureDetector(
                    onTap: () => Get.off(RegisterScreen()),
                    child: Text(
                      'Register',
                      style: TextStyle(color: Color(0xFFA31103)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
