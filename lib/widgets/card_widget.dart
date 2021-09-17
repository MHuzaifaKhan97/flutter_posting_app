import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardWidget extends StatelessWidget {
  String title;
  String desc;
  String date;
  String imageURL;
  VoidCallback onUpdatePress;
  VoidCallback OnDeletePress;

  CardWidget(
      {this.title = "",
      this.desc = "",
      this.date = "",
      this.imageURL = "",
      required this.onUpdatePress,
      required this.OnDeletePress});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.network(
                imageURL,
                // scale: 4,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    GestureDetector(
                        child: Icon(Icons.edit), onTap: onUpdatePress),
                    IconButton(
                        icon: Icon(Icons.delete), onPressed: OnDeletePress),
                  ],
                )
              ],
            ),
            SizedBox(height: 8),
            Text(desc, style: TextStyle(fontSize: 15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(date, style: TextStyle(fontSize: 14, color: Colors.grey))
              ],
            )
          ],
        ),
      ),
    );
  }
}
