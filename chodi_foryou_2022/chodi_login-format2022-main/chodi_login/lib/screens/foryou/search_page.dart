import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class search_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return search_page_state();
  }
}

class search_page_state extends State<search_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Colors.grey.shade400,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(),
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: Icon(Icons.search),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
