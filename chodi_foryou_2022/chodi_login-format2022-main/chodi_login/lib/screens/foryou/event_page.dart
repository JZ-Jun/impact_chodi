import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class event_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return event_page_state();
  }
}

class event_page_state extends State<event_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        backgroundColor: Colors.grey.shade400,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
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
                  child: const Text('Upcoming Event',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
            SizedBox(height: 10),
            buildItem('10', '24', 'Fir Aid State Basketball Tournament'),
            const SizedBox(height: 10),
            Container(
              height: 1,
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: 10),
            buildItem('2', '30', 'Blood Donation Activity'),
            const SizedBox(height: 15),
            Container(
              height: 1,
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  buildItem(String hour, String date, String str) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          child: Text(
            '$hour\nHour',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
            child: Container(
          height: 110,
          margin: EdgeInsets.only(left: 0, right: 40),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.all(const Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 60,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      '$date\nMar',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image.asset('assets/images/heart2.png',
                      width: 30, height: 30, fit: BoxFit.fill),
                ],
              ),
              SizedBox(height: 10),
              Text('$str')
            ],
          ),
        ))
      ],
    );
  }
}
