import 'package:flutter/material.dart';
import 'package:intl/intl.dart' ;
import 'package:flutter_chodi_app/models/event.dart';
import 'package:flutter_chodi_app/models/favorite.dart' ;
import 'package:flutter_chodi_app/screens/calendar/search_event_page.dart';
import 'package:flutter_chodi_app/screens/foryou/search_page.dart';
import 'package:r_calendar/r_calendar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/nonprofit_organization.dart';
import '../impact/impact_screen.dart';
import 'event_detail_page2.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int typeIndex = 0;
  bool _isBookmark = false;
  bool _isFavoriteExplore = false;
  bool _isFavoriteLikes = true;

  late Stream<QuerySnapshot> allNGOs ;

  late Stream<QuerySnapshot> likedEvents = FirebaseFirestore.instance.collection("EndUsers").doc(FirebaseAuth.instance.currentUser?.uid).collection("Favorites").snapshots() ;

  String? email = FirebaseAuth.instance.currentUser?.email ;

  List<Event> eventList = [] ;
  List<Favorite> favoriteList = [] ;
  List<Event> favoritedEventList = [] ;
  List<Event> registeredEventList = [] ;

  //builds eventList
  //intended to be run during init
  //Takes a list of all NGOs as an input. While that's technically unneseccary since NGOList is a
  //global constant, it isn't intended for it to always be one, so I've given this inputs in the hopes
  //a smarter person can circumvent the need to have a global constant like that.
  buildEventList(List<NonProfitOrg> orgList) {
    //print(NGOList);
  }

  @override
  void initState() {
    super.initState();

    //buildEventList(NGOList) ;


  }

/*  //Stream<QuerySnapshot> NGOS

  }*/

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
                          Text('Fammily Fridays',
                              style: TextStyle(fontSize: 28)),
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Events (User)").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Container();
          } else {
            eventList.clear();

            //add each of these events to the eventList
            for (var i in snapshot.data!.docs) {
              eventList.add(Event.fromFirestore(i));
            }

          }


          return StreamBuilder(
              stream: likedEvents,
              builder: (BuildContext context, AsyncSnapshot snapshot)
          {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Container();
            } else {
              favoriteList.clear();

              //make a list of all the favorites
              for (var i in snapshot.data!.docs) {
                favoriteList.add(Favorite.fromFirestore(i));
              }


              //iterate through the list of all favorites, and find all of the favorites which
              //are events, rather than orgs. Add those to the favorited events list
              for (int i = 0; i < favoriteList.length; i++) {
                if (!favoriteList[i].isOrg) {
                  for (int i = 0; i < eventList.length; i++) {
                    if (eventList[i].eventID == favoriteList[i].eventCode) {
                      favoritedEventList.add(eventList[i]);
                    }
                  }
                }
              }

              //iterate through the list of all events, checking for events which have the user on their
              //attendee list. Add those events to the registeredEventList
              for (int i = 0 ; i < eventList.length ; i++){
                for (int j = 0 ; j < eventList[i].attendees.length ; j++ ){
                  if (eventList[i].attendees.containsValue(email)){
                    registeredEventList.add(eventList[i]) ;
                  }
                }
              }

              //print(registeredEventList[0].imageURL.toString());
            }

            return Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('C',
                        style: TextStyle(fontSize: 25, color: Colors.yellow)),
                    Text('H',
                        style: TextStyle(fontSize: 25, color: Colors.orange)),
                    Text(
                        'O', style: TextStyle(fontSize: 25, color: Colors.red)),
                    Text('D',
                        style: TextStyle(fontSize: 25, color: Colors.blue)),
                    Text('I',
                        style: TextStyle(fontSize: 25, color: Colors.green))
                  ],
                ),
                centerTitle: true,
                backgroundColor: Colors.grey.shade400,
                elevation: 0,
                actions: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
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
                                typeIndex == 0 ? Colors.grey : Colors.grey
                                    .shade300,
                                borderRadius: BorderRadius.all(Radius.circular(
                                    20))),
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
                                typeIndex == 1 ? Colors.grey : Colors.grey
                                    .shade300,
                                borderRadius: BorderRadius.all(Radius.circular(
                                    20))),
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
                                typeIndex == 2 ? Colors.grey : Colors.grey
                                    .shade300,
                                borderRadius: BorderRadius.all(Radius.circular(
                                    20))),
                            child: Text('Explore'),
                          ))
                    ],
                  ),
                  Expanded(child: buildMain())
                ],
              ),
            );
          });
        });
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
                    child: Text('Displaying all' + eventList.length.toString() +
                        'events')),
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
          width: MediaQuery
              .of(context)
              .size
              .width,
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
                      //ideally all of the [0]'s below would become [i] or some other way to iterate through the whole list
                      Text(favoritedEventList[0].name,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text(favoritedEventList[0].orgName),
                      SizedBox(height: 5),
                      Text(favoritedEventList[0].locationDescription),
                    ],
                  )
                ],
              ),
              SizedBox(height: 15),
              Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                      favoritedEventList[0].description)),
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
                          _isFavoriteLikes = !_isFavoriteLikes;
                        });
                      },
                      child: _isFavoriteLikes
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
          width: MediaQuery
              .of(context)
              .size
              .width,
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
                      Text(eventList[0].name,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text(eventList[0].orgName),
                      SizedBox(height: 5),
                      Text(eventList[0].locationDescription),
                    ],
                  )
                ],
              ),
              SizedBox(height: 15),
              Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                      eventList[0].description)),
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
                          _isFavoriteExplore = !_isFavoriteExplore;
                        });
                      },
                      child: _isFavoriteExplore
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
              'Displaying'+ registeredEventList.length.toString() + 'registered events',
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


  //may want to turn into a string that takes in a List<Event> (ie. registeredEventsList)
  //and builds items for every item on the list
  //for now I'll just update to take from first index in the list
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
              Text(registeredEventList[0].name,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(DateFormat('EEEE, MMMM dd - ').add_jm().format(registeredEventList[0].startTime.toDate().toLocal()) ),
              SizedBox(height: 8),
              Text(registeredEventList[0].locationDescription),
              SizedBox(height: 15),
              Container(
                  alignment: Alignment.center,
                  child: Image.network(registeredEventList[0].imageURL!, width: 120))
            ],
          ),
        ));
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
}
