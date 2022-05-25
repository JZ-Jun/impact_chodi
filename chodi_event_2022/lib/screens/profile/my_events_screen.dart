import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/event.dart';
import 'package:flutter_chodi_app/screens/calendar/event_detail_page2.dart';
import 'package:intl/intl.dart';
import 'package:quiver/iterables.dart';

import '../foryou/event_detail_page.dart';

// ignore: camel_case_types
class my_events_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return my_events_screenState();
  }
}

// ignore: camel_case_types
class my_events_screenState extends State<my_events_screen> {
  final FirebaseAuth _user = FirebaseAuth.instance;
  late Stream registeredEventIDStream;

  late List<String> registeredEventIDList = [];

  int lastLoadedRegisteredEvents = 0;

  clearRegisteredEventIDList() {
    registeredEventIDList.clear();
  }

  String convertTimestampToDate(Timestamp startDateStamp) {
    var startDate = DateFormat.yMMMMd().format(startDateStamp.toDate());
    return startDate;
  }

  @override
  void initState() {
    super.initState();

    registeredEventIDStream = FirebaseFirestore.instance
        .collection("EndUsers")
        .doc(_user.currentUser!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: registeredEventIDStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Container();
          } else {
            clearRegisteredEventIDList();

            for (var i in snapshot.data["registeredFor"].entries) {
              registeredEventIDList.add(i.key.toString());
            }

            /*
            var regEventsQueryList = partition(registeredEventIDList, 10)
                .toList(); //get 10 registered events
            //[ [10 events] [10 events] [10 events] ]
            */
            return StreamBuilder<Object>(
                stream: FirebaseFirestore.instance
                    .collection("Events (User)")
                    //.where("eventCode", whereIn: regEventsQueryList[lastLoadedRegisteredEvents])

                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot2) {
                  if (snapshot2.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot2.hasError) {
                    return Container();
                  } else {
                    List<Event> regEventList = [];
                    for (var i in snapshot2.data.docs) {
                      for (var y in registeredEventIDList) {
                        if (i["eventCode"] == y) {
                          regEventList.add(Event.fromFirestore(i));
                        }
                      }
                    }

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
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 20),
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        //横轴元素个数
                                        crossAxisCount: 2,
                                        //纵轴间距
                                        mainAxisSpacing: 20.0,
                                        //横轴间距
                                        crossAxisSpacing: 20.0,
                                        //子组件宽高长度比例
                                        childAspectRatio: 0.8),
                                itemBuilder: (context, index) {
                                  return buildItem(
                                      regEventList[index].name,
                                      regEventList[index].startTime,
                                      "${regEventList[index].city}, ${regEventList[index].state}",
                                      regEventList[index].imageURL,
                                      regEventList[index]);
                                },
                                itemCount:
                                    snapshot.data["registeredFor"].length),
                          ),
                        ),
                      ),
                    );
                  }
                });
          }
        });
  }

  buildItem(var eventName, Timestamp eventStartDate, var location, var imageURL,
      Event ngoEvent) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return event_detail_page(
              ngoEvent: ngoEvent,
              ngoName: ngoEvent.orgName,
              ngoEIN: ngoEvent.ein,
            );
          }));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(eventName,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(DateFormat('MMMM dd yyyy,')
                  .add_jm()
                  .format(eventStartDate.toDate().toLocal())),
              const SizedBox(height: 8),
              Text(location),
              const SizedBox(height: 15),
              Container(
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    imageUrl: imageURL,
                    width: 120,
                  ))
            ],
          ),
        ));
  }
}
