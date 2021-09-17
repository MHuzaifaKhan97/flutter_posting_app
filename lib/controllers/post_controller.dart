import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final postTitleC = TextEditingController();
  final postDescC = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String imageURL = "";

  UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  // Fetch Posts
  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference products = firestore.collection('posts');
    return products.orderBy("date").snapshots();
  }
}
