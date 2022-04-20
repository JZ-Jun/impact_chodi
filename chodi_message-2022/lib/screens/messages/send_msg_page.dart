import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class send_msg_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return send_msg_page_state();
  }
}

class send_msg_page_state extends State<send_msg_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(10),
          child: Stack(children: [
            SingleChildScrollView(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Colors.grey.shade200),
                          alignment: Alignment.center,
                          child: Icon(Icons.arrow_back,
                              color: Colors.grey.shade600),
                        )),
                    Text(
                      'Health4Kids',
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                    )
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  height: 1,
                  color: Colors.grey.shade200,
                ),
                SizedBox(height: 15),
                buildSendMsg('Monday 11:11 AM', 'Are you available now?'),
                buildSendMsg('Monday 11:11 AM',
                    'We need to discuss about the future of the event!'),
                buildReceive('Monday 11:11 AM',
                    'We need to discuss about the future of the event!,We need to discuss about the future of the event!,We need to discuss about the future of the event!'),
              ],
            )),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.black),
                      Expanded(child: TextField()),
                      Icon(Icons.send, color: Colors.black),
                    ],
                  ),
                ))
          ])),
    );
  }

  buildSendMsg(String time, String msg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('$time')],
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.grey.shade300),
          child: Text(
            '$msg',
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }

  buildReceive(String time, String msg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('$time')],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Image.asset(
                  'assets/images/for_you.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.fill,
                )),
            SizedBox(width: 10),
            Container(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.grey.shade300),
              child: Text(
                '$msg',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        SizedBox(height: 20)
      ],
    );
  }
}
