import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_posting_app/controllers/auth_controller.dart';
import 'package:flutter_posting_app/screens/addpost_screen.dart';
import 'package:flutter_posting_app/screens/login_screen.dart';
import 'package:flutter_posting_app/screens/splash_screen.dart';
import 'package:flutter_posting_app/widgets/loading_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            title: 'Posting App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Color(0xFFA31103),
              textTheme: GoogleFonts.amaranthTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            // home: AddPostScreen(),
            home: snapshot.data != null ? HomeScreen() : SplashScreen(),
          );
        }
        return LoadingWidget();
      },
    );
  }
}
