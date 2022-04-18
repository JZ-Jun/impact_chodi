import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class event_detail_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return event_detail_page_state();
  }
}

class event_detail_page_state extends State<event_detail_page> {
  bool _isMark = false;
  bool _isShare = false;
  bool _isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Event Details', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //修改颜色
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Image.asset(
                      'assets/images/for_you.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    )),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('The Giving Spirit',
                          style: const TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      Text('White Outreach Challenge',
                          style: const TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Registration'),
                                        content: Text(
                                            'There are 50 spaces available.\nWould you like to register?'),
                                        actions: [
                                          GestureDetector(
                                            onTap: () =>
                                                Navigator.pop(context, 1),
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 15),
                                                padding: EdgeInsets.all(3),
                                                child: Text('Yes',
                                                    style: const TextStyle(
                                                        color: Colors.blue))),
                                          ),
                                          GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: Padding(
                                                padding: EdgeInsets.all(3),
                                                child: Text('Cancel',
                                                    style: const TextStyle(
                                                        color: Colors.blue))),
                                          )
                                        ],
                                      );
                                    }).then((value) {
                                  if (value == 1) {
                                    setState(() {
                                      _isMark = !_isMark;
                                    });
                                  }
                                });
                              },
                              icon: _isMark
                                  ? Icon(Icons.bookmark, color: Colors.yellow)
                                  : Icon(Icons.bookmark_border)),
                          SizedBox(width: 5),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _isShare = !_isShare;
                                });
                              },
                              icon: _isShare
                                  ? Icon(Icons.share, color: Colors.blue)
                                  : Icon(Icons.share)),
                          SizedBox(width: 5),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _isFavorite = !_isFavorite;
                                });
                              },
                              icon: _isFavorite
                                  ? const Icon(Icons.favorite,
                                      color: Colors.red)
                                  : const Icon(Icons.favorite_border))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 1,
              color: Colors.grey.shade200,
            ),
            SizedBox(height: 10),
            Text('Description', style: const TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text(
                'Thanks to your amazing generoslty, our small group of volunteers have personally sereved more than 49,000 souls in Greater LA.With your support, The giving Spirits provided food, blankets, clothing',
                style: const TextStyle(fontSize: 15)),
            SizedBox(height: 10),
            Text('show more',
                style: const TextStyle(fontSize: 15, color: Colors.blue)),
            SizedBox(height: 30),
            Text('Date', style: const TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('December 12, 2020 - December 15, 2020',
                style: const TextStyle(fontSize: 15)),
            SizedBox(height: 30),
            Text('Time', style: const TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Time Not Available', style: const TextStyle(fontSize: 15)),
            SizedBox(height: 30),
            Text('Location', style: const TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(
                '1693 San Vicente Blvd #113\nLos Angeles, CA 90049 United States',
                style: const TextStyle(fontSize: 15)),
            SizedBox(height: 10),
            Center(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text('map'),
              ),
            )
          ],
        )),
      ),
    );
  }
}
