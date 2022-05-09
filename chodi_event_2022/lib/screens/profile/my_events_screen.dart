import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/calendar/event_detail_page2.dart';
import 'package:flutter_chodi_app/screens/calendar/search_event_page.dart';
import 'package:flutter_chodi_app/screens/foryou/search_page.dart';
import 'package:r_calendar/r_calendar.dart';

class my_events_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return my_events_screenState();
  }
}

class my_events_screenState extends State<my_events_screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: null,
        builder: (context, AsyncSnapshot snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Registered Events'),
              centerTitle: true,
              backgroundColor: Colors.grey.shade400,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: GridView.builder(
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
                      itemCount: 20),
                ),
              ),
            ),
          );
        });
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
