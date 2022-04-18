import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class contact_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return contact_page_state();
  }
}

class contact_page_state extends State<contact_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.grey.shade200),
                      alignment: Alignment.center,
                      child:
                          Icon(Icons.arrow_back, color: Colors.grey.shade600),
                    )),
                Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  width: 40,
                  height: 40,
                )
              ],
            ),
            SizedBox(height: 60),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              margin: EdgeInsets.only(left: 50, right: 50),
              padding: EdgeInsets.only(left: 25, right: 15),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Contact Email'),
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              margin: EdgeInsets.only(left: 50, right: 50),
              padding: EdgeInsets.only(left: 25, right: 15),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Subject'),
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              margin: EdgeInsets.only(left: 50, right: 50),
              padding: EdgeInsets.only(left: 25, right: 15),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type Your Question Here'),
              ),
            ),
            SizedBox(height: 80),
            Container(
              width: 100,
              height: 40,
              margin: EdgeInsets.only(left: 50, right: 50),
              padding: EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              alignment: Alignment.center,
              child: Text(
                'Send',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
