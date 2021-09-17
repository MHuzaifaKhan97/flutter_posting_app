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
  RxBool isLoading = false.obs;

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
    CollectionReference posts = firestore.collection('posts');
    return posts.orderBy("date", descending: true).snapshots();
  }

  // ADD Post
  addPost(BuildContext context, String title, String desc) async {
    CollectionReference posts = firestore.collection('posts');

    try {
      if (title == "") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please enter post title"),
          backgroundColor: Color(0xFFA31103),
        ));
        return;
      }
      if (desc == "") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please enter post descrption"),
          backgroundColor: Color(0xFFA31103),
        ));
        return;
      }
      if (imageURL == "") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please select image"),
          backgroundColor: Color(0xFFA31103),
        ));
        return;
      } else {
        var date = DateTime.now().toString().split('.')[0];
        isLoading(true);

        await posts.add(
            {"title": title, "desc": desc, "imageURL": imageURL, "date": date});
        isLoading(false);

        Get.defaultDialog(
          title: "Post Added",
          content: Text("Post Succesfully Added"),
          confirm: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Color(0xFFA31103)),
              onPressed: () {
                postTitleC.clear();
                postDescC.clear();
                Get.back();
                Get.back();
              },
              child: Text('Okay')),
        );
      }
    } on FirebaseException catch (e) {
      Get.defaultDialog(
          title: "Error",
          content: Text(e.message.toString()),
          onConfirm: () => Get.back(),
          textConfirm: "Okay");
    }
  }

  // Delete Post
  deleteProduct(String docId) async {
    DocumentReference post = firestore.collection('posts').doc(docId);
    try {
      isLoading(true);
      await post.delete();
      isLoading(false);

      Get.defaultDialog(
        title: "Post Deleted",
        content: Text("Post Succesfully Deleted"),
        confirm: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Color(0xFFA31103)),
            onPressed: () {
              Get.back();
            },
            child: Text('Okay')),
      );
    } on FirebaseException catch (e) {
      Get.defaultDialog(title: 'Error', content: Text(e.message.toString()));
    }
  }
}
