import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_posting_app/controllers/auth_controller.dart';
import 'package:flutter_posting_app/controllers/post_controller.dart';
import 'package:flutter_posting_app/screens/addpost_screen.dart';
import 'package:flutter_posting_app/screens/editpost_screen.dart';
import 'package:flutter_posting_app/screens/signup_screen.dart';
import 'package:flutter_posting_app/widgets/card_widget.dart';
import 'package:flutter_posting_app/widgets/custom_textField.dart';
import 'package:flutter_posting_app/widgets/loading_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authController = Get.find<AuthController>();
  final postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: postController.streamData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              print(snapshot.data!.docs);
              var listOfPosts = snapshot.data!.docs;
              return postController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFA31103),
                      ),
                    )
                  : listOfPosts.length == 0
                      ? Center(
                          child: Text(
                            'No Post Added Yet.',
                            style: TextStyle(
                                color: Color(0xFFA31103), fontSize: 22),
                          ),
                        )
                      : ListView.builder(
                          itemCount: listOfPosts.length,
                          itemBuilder: (context, index) {
                            return CardWidget(
                              title: (listOfPosts[index].data()
                                  as Map<String, dynamic>)["title"],
                              desc: (listOfPosts[index].data()
                                  as Map<String, dynamic>)["desc"],
                              imageURL: (listOfPosts[index].data()
                                  as Map<String, dynamic>)["imageURL"],
                              date: (listOfPosts[index].data()
                                  as Map<String, dynamic>)["date"],
                              onUpdatePress: () {
                                Get.offAll(EditPostScreen(
                                  title: (listOfPosts[index].data()
                                      as Map<String, dynamic>)["title"],
                                  desc: (listOfPosts[index].data()
                                      as Map<String, dynamic>)["desc"],
                                  imageURL: (listOfPosts[index].data()
                                      as Map<String, dynamic>)["imageURL"],
                                  docId: listOfPosts[index].id,
                                ));
                                print("updatePressed");
                              },
                              OnDeletePress: () async {
                                await postController
                                    .deleteProduct(listOfPosts[index].id);
                                print("Delete Pressed");
                                setState(() {});
                              },
                            );
                            // return ListTile(
                            //   // onTap: () => Get.to(
                            //   // EditProductScreen(
                            //   //   name: (listOfPosts[index].data()
                            //   //       as Map<String, dynamic>)["name"],
                            //   //   price: (listOfPosts[index].data()
                            //   //       as Map<String, dynamic>)["price"],
                            //   // ),
                            //   // arguments: listOfPosts[index].id),
                            //   title: Text((listOfPosts[index].data()
                            //       as Map<String, dynamic>)["title"]),
                            //   subtitle: Text((listOfPosts[index].data()
                            //       as Map<String, dynamic>)["desc"]),
                            //   trailing: IconButton(
                            //     icon: Icon(Icons.delete),
                            //     onPressed: () async {
                            //       // await homeController
                            //       //     .deleteProduct(listOfProducts[index].id);
                            //     },
                            //   ),
                            // );
                          });
            }
            return Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFA31103),
        onPressed: () {
          Get.to(AddPostScreen());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 32,
            ),
            // Text(
            //   'Add',
            //   textAlign: TextAlign.center,
            // ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
