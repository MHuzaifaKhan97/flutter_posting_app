import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_posting_app/controllers/auth_controller.dart';
import 'package:flutter_posting_app/controllers/post_controller.dart';
import 'package:flutter_posting_app/widgets/button_widget.dart';
import 'package:flutter_posting_app/widgets/custom_textField.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class EditPostScreen extends StatefulWidget {
  String title;
  String desc;
  String imageURL;
  String docId;
  EditPostScreen(
      {required this.title,
      required this.desc,
      required this.imageURL,
      required this.docId});
  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final authController = Get.find<AuthController>();
  final postController = Get.put(PostController());
  UploadTask? task;

  File? file;

  @override
  void initState() {
    super.initState();
    postController.postTitleC.text = widget.title;
    postController.postDescC.text = widget.desc;
    postController.imageURL = widget.imageURL;
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
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
              bottom: Radius.circular(20),
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
                    'Edit Post'.toUpperCase(),
                    style: GoogleFonts.amaranth(
                        fontSize: 40, color: Color(0xFFA31103)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  CustomTextFieldWidget(
                    hintValue: 'Enter Title',
                    controller: postController.postTitleC,
                  ),
                  SizedBox(height: 16),
                  CustomTextFieldWidget(
                    hintValue: 'Enter Description',
                    controller: postController.postDescC,
                    type: TextInputType.multiline,
                    maxLength: 300,
                    minLines: 3,
                    maxLines: 5,
                  ),
                  SizedBox(height: 14),
                  postController.imageURL != ""
                      ? Container(
                          width: 200,
                          height: 200,
                          child: Image.network(widget.imageURL))
                      : Container(),
                  SizedBox(height: 14),
                  task != null ? buildUploadStatus(task!) : Container(),
                  SizedBox(height: 6),

                  ButtonWidget(
                    text: 'Upload File',
                    icon: Icons.cloud_upload_outlined,
                    onClicked: () async {
                      postController.imageURL = await selectAndUploadFile();
                      setState(() {
                        widget.imageURL = postController.imageURL;
                      });
                    },
                  ),
                  SizedBox(height: 32),
                  // Text(
                  //   fileName,
                  //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  // ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(45),
                        primary: Color(0xFFA31103)),
                    onPressed: () async {
                      await postController.updatePost(
                          context,
                          postController.postTitleC.text,
                          postController.postDescC.text,
                          widget.docId);
                    },
                    child: postController.isLoading.value
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : Text(
                            'Edit Post',
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          );
        }));
  }

  Future<dynamic> selectAndUploadFile() async {
    var date = DateTime.now().toString().split('.')[0];
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;
    file = File(path);
    setState(() => file = File(path));
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = postController.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    return urlDownload;
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            return Text(
              percentage == "100.00" ? 'File Uploaded..!' : '$percentage %',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFA31103)),
            );
          } else {
            return Container();
          }
        },
      );
}
