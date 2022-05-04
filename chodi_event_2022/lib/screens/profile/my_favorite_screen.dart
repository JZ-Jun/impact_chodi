import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/nonprofit_organization.dart';
import 'package:flutter_chodi_app/screens/calendar/event_detail_page2.dart';
import 'package:flutter_chodi_app/screens/calendar/search_event_page.dart';
import 'package:flutter_chodi_app/screens/foryou/detail_page.dart';
import 'package:flutter_chodi_app/screens/foryou/search_page.dart';
import 'package:r_calendar/r_calendar.dart';

class my_favorite_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return my_favorite_screenState();
  }
}

class my_favorite_screenState extends State<my_favorite_screen> {
  int typeIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My favorite'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade400,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    typeIndex = 0;
                  });
                },
                child: Container(
                  width: 150,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: typeIndex == 0
                          ? Colors.grey.shade600
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text('Events'),
                )),
            GestureDetector(
                onTap: () {
                  setState(() {
                    typeIndex = 1;
                  });
                },
                child: Container(
                  width: 150,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: typeIndex == 1
                          ? Colors.grey.shade600
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text('Organizations'),
                ))
          ]),
          SizedBox(height: 30),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: getGridView(),
          ))
        ],
      ),
    );
  }

  getGridView() {
    switch (typeIndex) {
      case 0:
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //横轴元素个数
                crossAxisCount: 2,
                //纵轴间距
                mainAxisSpacing: 20.0,
                //横轴间距
                crossAxisSpacing: 20.0,
                //子组件宽高长度比例
                childAspectRatio: 0.8),
            itemBuilder: (context, index) {
              return buildItem();
            },
            itemCount: 2);
      case 1:
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //横轴元素个数
                crossAxisCount: 2,
                //纵轴间距
                mainAxisSpacing: 20.0,
                //横轴间距
                crossAxisSpacing: 20.0,
                //子组件宽高长度比例
                childAspectRatio: 0.8),
            itemBuilder: (context, index) {
              return buildItemOrg();
            },
            itemCount: 2);
      default:
    }
  }

  buildItemOrg() {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Detail_Page(
              ngoInfo: NonProfitOrg(ein: '1', name: '2'),
            );
          }));
        },
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/fy.png', width: 150)),
              SizedBox(height: 8),
              Expanded(
                  child: Container(
                      color: Colors.grey.shade300,
                      alignment: Alignment.center,
                      child: Text('Adopting/Fostering',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)))),
            ],
          ),
        ));
  }

  buildItem() {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return event_detail_page2();
          }));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Adopting/Fostering',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('January 1,2022'),
              SizedBox(height: 8),
              Text('San Martin,Ca'),
              SizedBox(height: 15),
              Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/fy.png', width: 120))
            ],
          ),
        ));
  }
}
