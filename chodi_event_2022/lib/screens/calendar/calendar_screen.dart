import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/calendar/search_event_page.dart';
import 'package:flutter_chodi_app/screens/foryou/search_page.dart';
import 'package:r_calendar/r_calendar.dart';

import 'event_detail_page2.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int typeIndex = 0;
  bool _isBookmark = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  showDetailDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Container(
              child: Container(
                  height: 400,
                  color: Colors.grey.shade100,
                  margin: EdgeInsets.only(top: 60, bottom: 60),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.keyboard_arrow_down, size: 30)),
                      SizedBox(height: 10),
                      Text('Ronald McDonald Childrens Charities San Deigo'),
                      SizedBox(height: 15),
                      Text('Fammily Fridays', style: TextStyle(fontSize: 28)),
                      SizedBox(height: 15),
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        alignment: Alignment.center,
                        child:
                            Image.asset('assets/images/qrcode.png', width: 110),
                      ),
                      SizedBox(height: 15),
                      Text('Volunteer'),
                      SizedBox(height: 10),
                      Text(
                        'Thi Nguyen',
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(height: 15),
                      Text('Ticket / Seating'),
                      SizedBox(height: 10),
                      Text(
                        'Generaln',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Date',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('December 12,2020 - December 15,2020'),
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Time',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('12:00 AM - 11:00 PM'),
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Location',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('1693 San Vicente Blvd #113 '),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Los Angeles,CA 90049 United States'),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        alignment: Alignment.center,
                        child: Text('map'),
                      ),
                      SizedBox(height: 15),
                    ],
                  ))));
        });
  }

  showDateDialog() {
    RCalendarController controller = RCalendarController.single(
        selectedDate: DateTime.now(), isAutoSelect: true)
      ..addListener(() {});
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Material(
              color: Colors.transparent,
              child: Container(
                  child: Container(
                      margin: const EdgeInsets.only(top: 100, bottom: 10),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.keyboard_arrow_down, size: 30)),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.transparent,
                              ),
                              Text('Agenda', style: TextStyle(fontSize: 28)),
                              Icon(
                                Icons.calendar_today,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            alignment: Alignment.center,
                            child: RCalendarWidget(
                              controller: controller,
                              customWidget: DefaultRCalendarCustomWidget(),
                              firstDate: DateTime(1970, 1, 1),
                              lastDate: DateTime.now(),
                            ),
                          ),
                        ],
                      ))));
        });
  }

  showTipDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Registration'),
            content: const Text(
                'There are 50 spaces available. Would you like register?'),
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context, 1),
                child: Container(
                    margin: const EdgeInsets.only(right: 15),
                    padding: const EdgeInsets.all(3),
                    child: const Text('Yes',
                        style: TextStyle(color: Colors.blue))),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                    padding: EdgeInsets.all(3),
                    child:
                        Text('Cancel', style: TextStyle(color: Colors.blue))),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('C', style: TextStyle(fontSize: 25, color: Colors.yellow)),
            Text('H', style: TextStyle(fontSize: 25, color: Colors.orange)),
            Text('O', style: TextStyle(fontSize: 25, color: Colors.red)),
            Text('D', style: TextStyle(fontSize: 25, color: Colors.blue)),
            Text('I', style: TextStyle(fontSize: 25, color: Colors.green))
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade400,
        elevation: 0,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return search_event_page();
                }));
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                child: const Icon(Icons.search),
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(15),
              child: Text(
                'Events',
                style: TextStyle(color: Colors.grey, fontSize: 30),
              )),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      typeIndex = 0;
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:
                            typeIndex == 0 ? Colors.grey : Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text('RSVP'),
                  )),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      typeIndex = 1;
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:
                            typeIndex == 1 ? Colors.grey : Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text('Likes'),
                  )),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      typeIndex = 2;
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:
                            typeIndex == 2 ? Colors.grey : Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text('Explore'),
                  ))
            ],
          ),
          Expanded(child: buildMain())
        ],
      ),
    );
  }

  buildMain() {
    switch (typeIndex) {
      case 0:
        return buildRsvp();
      case 1:
        return Column(
          children: [buildLikes()],
        );
      case 2:
        return SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text('Displaying all 9 events')),
            buildExplore(),
            buildExplore(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('More'),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                SizedBox(width: 15),
              ],
            ),
            SizedBox(height: 10),
          ],
        ));
      default:
    }
  }

  buildLikes() {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return event_detail_page2();
          }));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(30),
          padding: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/images/fy.png', width: 120),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Adopting/Fostering',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('All Animal Rescue & Friends '),
                      SizedBox(height: 5),
                      Text('San Martin ,CA'),
                    ],
                  )
                ],
              ),
              SizedBox(height: 15),
              Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                      'We are a 501(C)3 non-profit all volunteer rescue organization focused on physically rescuing and reuniting lost/found animals within our community.')),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        showTipDialog();
                        setState(() {
                          _isBookmark = !_isBookmark;
                        });
                      },
                      child: _isBookmark
                          ? Icon(Icons.bookmark, color: Colors.yellow)
                          : Icon(Icons.bookmark_border)),
                  SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                      child: _isFavorite
                          ? const Icon(Icons.favorite, color: Colors.red)
                          : const Icon(Icons.favorite_border)),
                  SizedBox(width: 10),
                ],
              )
            ],
          ),
        ));
  }

  buildExplore() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return event_detail_page2();
        }));
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 10),
          padding: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/images/fy.png', width: 120),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Adopting/Fostering',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('All Animal Rescue & Friends '),
                      SizedBox(height: 5),
                      Text('San Martin ,CA'),
                    ],
                  )
                ],
              ),
              SizedBox(height: 15),
              Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                      'We are a 501(C)3 non-profit all volunteer rescue organization focused on physically rescuing and reuniting lost/found animals within our community.')),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text('1234 mi'),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                      onTap: () {
                        showTipDialog();
                        setState(() {
                          _isBookmark = !_isBookmark;
                        });
                      },
                      child: _isBookmark
                          ? Icon(Icons.bookmark, color: Colors.yellow)
                          : Icon(Icons.bookmark_border)),
                  SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                      child: _isFavorite
                          ? const Icon(Icons.favorite, color: Colors.red)
                          : const Icon(Icons.favorite_border)),
                  SizedBox(width: 10),
                ],
              )
            ],
          )),
    );
  }

  buildRsvp() {
    return Column(
      children: [
        SizedBox(height: 25),
        GestureDetector(
            onTap: () => showDateDialog(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              color: Colors.orange.shade200,
              alignment: Alignment.center,
              child: Text('Agenda',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            )),
        Container(
            padding: EdgeInsets.all(15),
            child: Text(
              'Displaying 5 registered events',
              style: TextStyle(color: Colors.grey),
            )),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
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
              itemCount: 2),
        ))
      ],
    );
  }

  buildItem() {
    return GestureDetector(
        onTap: () => showDetailDialog(),
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
