import 'package:flutter/material.dart';

import 'send_msg_page.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<bool> isReads = [false, false, true, true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey.shade400,
            elevation: 0,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('C', style: TextStyle(fontSize: 25, color: Colors.yellow)),
                Text('H', style: TextStyle(fontSize: 25, color: Colors.orange)),
                Text('O', style: TextStyle(fontSize: 25, color: Colors.red)),
                Text('D', style: TextStyle(fontSize: 25, color: Colors.blue)),
                Text('I', style: TextStyle(fontSize: 25, color: Colors.green))
              ],
            )),
        body: Container(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('Inbox', style: TextStyle(fontSize: 25)),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    padding: EdgeInsets.only(left: 25, right: 15),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          maxLines: 1,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: '34 Message'),
                        )),
                        Container(
                          child: Icon(Icons.search, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Recent Messages', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  buildMsg(
                      0,
                      'assets/images/for_you.png',
                      'Health4Kids',
                      '45 mins ago',
                      'Hello John,this is cindy from help from...'),
                  buildMsg(1, 'assets/images/for_you.png', 'Greater Good',
                      '11:49 PM', 'Hello John,this is cindy from help from...'),
                  SizedBox(height: 10),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text('All Messages', style: TextStyle(fontSize: 16)),
                  buildMsg(
                      2,
                      'assets/images/for_you.png',
                      'Red Cross',
                      'Yesterday 7:12 AM',
                      'Hello John,this is cindy from help from...'),
                  buildMsg(
                      3,
                      'assets/images/for_you.png',
                      'Red Cross',
                      'March,27,2022',
                      'Hello John,this is cindy from help from...'),
                  buildMsg(
                      4,
                      'assets/images/for_you.png',
                      'G-Cause',
                      'March,11,2022',
                      'Hello John,this is cindy from help from...'),
                ]))));
  }

  buildMsg(int index, String img, String name, String time, String msg) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return send_msg_page();
          })).then((value) {
            setState(() {
              isReads[index] = true;
            });
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          margin: EdgeInsets.only(left: 30, right: 20, top: 10, bottom: 10),
          padding: EdgeInsets.only(left: 10, top: 5, right: 10),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: isReads[index] ? Colors.transparent : Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Image.asset(
                    '$img',
                    width: 50,
                    height: 50,
                    fit: BoxFit.fill,
                  )),
              SizedBox(width: 10),
              Expanded(
                  child: Column(
                children: [
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$name',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      Text('$time', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('$msg',
                      style: TextStyle(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ))
            ],
          ),
        ));
  }
}
