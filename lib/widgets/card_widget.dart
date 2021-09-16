import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  String title;
  String desc;
  String date;
  String imageURL;
  CardWidget(
      {this.title = "", this.desc = "", this.date = "", this.imageURL = ""});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageURL,
              scale: 4,
            ),
            SizedBox(height: 8),
            Text(title,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
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
