import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/event.dart';
import 'package:flutter_chodi_app/models/nonprofit_organization.dart';
import 'package:flutter_chodi_app/screens/foryou/event_detail_page.dart';
import 'package:nanoid/nanoid.dart';
import 'package:intl/intl.dart';
import 'dart:async';

//For unique event id, use nanoid (10 characters) to generate

// ignore: camel_case_types
class event_page extends StatefulWidget {
  final NonProfitOrg ngoInfo;

  const event_page({Key? key, required this.ngoInfo}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return event_page_state();
  }
}

_generateUniqueIDs() {
  var customLengthId = nanoid(10);
  log(customLengthId.toString());
}

// ignore: camel_case_types
class event_page_state extends State<event_page> {
  List<bool> isFavorite = [];
  late Stream dataList;
  List<int> ngoIntEvents = [1, 2, 3];
  List<Event> ngoEvents = [];

  bool _isFavorite = false;

  int? day;
  int? month;

  _clearList() {
    isFavorite.clear();
    ngoEvents.clear();
  }

  int _parseDayTimeStamp(Timestamp timestamp) {
    DateTime day = timestamp.toDate();

    return day.day;
  }

  String _parseMonthTimeStamp(Timestamp timestamp) {
    DateTime month = timestamp.toDate();

    return DateFormat.MMMM().format(month);
  }

  String? _liveTimer(Timestamp startTime) {
    DateTime dt1 = DateTime.parse(DateTime.now().toIso8601String());
    DateTime dt2 = DateTime.parse(startTime.toDate().toIso8601String());

    Duration diff = dt2.difference(dt1);

    int days = diff.inDays;

    if (days > 1) {
      return "$days \nDays";
    } else if (day == 1) {
      return "$days \nDay";
    } else if (days < 1) {
      int hours = diff.inHours;

      if (hours > 1) {
        return "$hours \nHours";
      } else if (hours == 1) {
        return "$hours \nHour";
      } else if (hours < 1) {
        int minutes = diff.inMinutes;

        if (minutes > 1) {
          return "$minutes \nMinutes";
        } else if (minutes == 1) {
          return "$minutes \nMinute";
        } else if (minutes < 1 && minutes >= 0) {
          int seconds = diff.inSeconds;
          return "$seconds \nSeconds";
        } else {
          return "Now";
        }
      }
    }

    return "none";
  }

  @override
  void initState() {
    dataList = FirebaseFirestore.instance
        .collection("Nonprofits/" + widget.ngoInfo.ein + "/Events")
        .orderBy("endTime", descending: true)
        .where("endTime", isGreaterThanOrEqualTo: DateTime.now())
        .snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dataList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Container();
          } else {
            _clearList();

            for (var i in snapshot.data!.docs) {
              ngoEvents.add(Event.fromFirestore(i));
              isFavorite.add(false);
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text('Event'),
                backgroundColor: Colors.grey.shade400,
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            _generateUniqueIDs();
                          },
                          child: const Text(
                              "Testing only - Generate Unique Event IDs")),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: CachedNetworkImage(
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                              imageUrl:
                                  widget.ngoInfo.imageURL!, //testing image
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 30),
                            child: const Text('Upcoming Events',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        child: SizedBox(
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return buildItem('10', index, ngoEvents[index]);
                              },
                              itemCount: ngoEvents.length,
                              scrollDirection: Axis.vertical),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  buildItem(String hour, int index, Event event) {
    int day = _parseDayTimeStamp(event.startTime);
    String month = _parseMonthTimeStamp(event.startTime);

    _liveTimer(event.startTime);

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return event_detail_page(
                  ngoEvent: event,
                  ngoName: widget.ngoInfo.name,
                );
              }));
            },
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    _liveTimer(event.startTime)!,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    child: Container(
                  height: 110,
                  margin: const EdgeInsets.only(left: 0, right: 40),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
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
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Text(
                              "$day\n$month",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _isFavorite = !_isFavorite;

                                  if (_isFavorite) {
                                    //add to firebase

                                  } else {
                                    //remove from firebase

                                  }
                                });
                              },
                              icon: _isFavorite
                                  ? const Icon(Icons.favorite,
                                      color: Colors.red)
                                  : const Icon(Icons.favorite_border))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(event.name),
                    ],
                  ),
                ))
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
