import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/foryou/contact_page.dart';
import 'package:flutter_chodi_app/screens/foryou/donate_page.dart';
import 'package:flutter_chodi_app/screens/foryou/event_page.dart';

class detail_page extends StatefulWidget {
  String str;
  detail_page(this.str);

  @override
  State<StatefulWidget> createState() {
    return detail_page_state();
  }
}

class detail_page_state extends State<detail_page> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.grey.shade400,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${widget.str}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Image.asset(
                        isFavorite
                            ? 'assets/images/heart2.png'
                            : 'assets/images/heart.jpeg',
                        width: 40,
                        height: 40,
                        fit: BoxFit.fill))
              ],
            ),
            SizedBox(height: 15),
            Text('212-679-6800'),
            SizedBox(height: 15),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Image.asset(
                      'assets/images/for_you.png',
                      width: 140,
                      height: 140,
                      fit: BoxFit.fill,
                    )),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Column(
                          children: [
                            getInfoItem('Location: New York', Icons.place),
                            getInfoItem(
                                'Categories:(human right)', Icons.equalizer),
                            getInfoItem('Year Founded: 1971', Icons.event),
                            getInfoItem('Size: 10001+', Icons.perm_identity)
                          ],
                        )))
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return donate_page();
                      }));
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      alignment: Alignment.center,
                      child: Text('DONATE'),
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return event_page();
                      }));
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      alignment: Alignment.center,
                      child: Text('EVENT'),
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return contact_page();
                      }));
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      alignment: Alignment.center,
                      child: Text('CONTACT'),
                    ))
              ],
            ),
            SizedBox(height: 15),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 15),
            Text('INFO',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                'Provides aid in nearly 60 countries to peopel whose survival is threatended by violence, neglect, or catastrophe, primarily due to armed conflict, epidemics, malnutrition, exclusion from health care, or naturedisasters.'),
            SizedBox(height: 15),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 15),
            Text('Website',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('https://www.doctorswithoutborders.org/',
                style: TextStyle(color: Colors.blue))
          ],
        ),
      ),
    );
  }

  getInfoItem(String txt, IconData iconData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [Icon(iconData, size: 25), SizedBox(width: 15), Text(txt)],
    );
  }
}
