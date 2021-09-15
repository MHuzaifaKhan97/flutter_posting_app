import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  // Login Controllers
  final loginEmailC = TextEditingController();
  final loginPasswordC = TextEditingController();
  // Register Controllers
  final signUpNameC = TextEditingController();
  final signUpEmailC = TextEditingController();
  final signUpPasswordC = TextEditingController();
  // Auth State Listener
  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  // signup(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await auth.createUserWithEmailAndPassword(
  //         email: email, password: password);

  //     if (userCredential.user != null && userCredential.user!.emailVerified) {
  //       Get.offAll(HomeScreen());
  //     } else {
  //       var response = await Get.defaultDialog(
  //           title: 'Email Verification',
  //           titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  //           middleText: 'Your email is not verified.',
  //           confirm: ElevatedButton(
  //               onPressed: () {
  //                 Get.back(result: true);
  //               },
  //               child: Text('Click to verify')));
  //       if (response != null && response == true) {
  //         await userCredential.user!.sendEmailVerification();
  //         Get.defaultDialog(
  //             title: 'Email Verification',
  //             titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  //             middleText: 'A verification link is sent to $email.',
  //             confirm: ElevatedButton(
  //                 onPressed: () {
  //                   Get.back();
  //                 },
  //                 child: Text('Okay')));
  //       }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       Get.defaultDialog(
  //           title: 'Warning',
  //           titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  //           middleText: 'Weak password',
  //           confirm: ElevatedButton(
  //               onPressed: () {
  //                 Get.back();
  //               },
  //               child: Text('Okay')));
  //     } else if (e.code == 'email-already-in-use') {
  //       Get.defaultDialog(
  //           title: 'Warning',
  //           titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  //           middleText: 'Email already exists',
  //           confirm: ElevatedButton(
  //               onPressed: () {
  //                 Get.back();
  //               },
  //               child: Text('Okay')));
  //     }
  //   }
  // }

  // login(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     if (userCredential.user!.emailVerified) {
  //       Get.offAll(HomeScreen());
  //     } else {
  //       var response = await Get.defaultDialog(
  //           title: 'Email Verification',
  //           titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  //           middleText: 'Your email is not verified.',
  //           confirm: ElevatedButton(
  //               onPressed: () {
  //                 Get.back(result: true);
  //               },
  //               child: Text('Click to verify')));
  //       if (response != null && response == true) {
  //         await userCredential.user!.sendEmailVerification();
  //         Get.defaultDialog(
  //             title: 'Email Verification',
  //             titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  //             middleText: 'A verification link is sent to $email.',
  //             confirm: ElevatedButton(
  //                 onPressed: () {
  //                   Get.back();
  //                 },
  //                 child: Text('Okay')));
  //       }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       Get.defaultDialog(
  //           title: 'Warning',
  //           titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  //           middleText: 'No user found',
  //           confirm: ElevatedButton(
  //               onPressed: () {
  //                 Get.back();
  //               },
  //               child: Text('Okay')));
  //     } else if (e.code == 'wrong-password') {
  //       Get.defaultDialog(
  //           title: 'Warning',
  //           titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  //           middleText: 'Username or password is incorrect',
  //           confirm: ElevatedButton(
  //               onPressed: () {
  //                 Get.back();
  //               },
  //               child: Text('Okay')));
  //     }
  //   }
  // }

  void logout() async {
    await auth.signOut();
  }
}
