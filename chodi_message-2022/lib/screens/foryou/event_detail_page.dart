import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/event.dart';
import 'package:flutter_chodi_app/widget/share_modal.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
//import 'package:share_plus/share_plus.dart';
import '../../services/firebase_authentication_service.dart';

// ignore: camel_case_types, must_be_immutable
class event_detail_page extends StatefulWidget {
  Event ngoEvent;
  String ngoName;
  String ngoEIN;

  event_detail_page(
      {Key? key,
      required this.ngoEvent,
      required this.ngoName,
      required this.ngoEIN})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return event_detail_page_state();
  }
}

// ignore: camel_case_types
class event_detail_page_state extends State<event_detail_page> {
  final ShareModal shareModal = ShareModal();
  final FirebaseService fbservice = FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Stream<DocumentSnapshot> favoriteList;
  late Stream<DocumentSnapshot> registeredForList;

  bool _isMark = false;
  bool _isShare = false;
  bool _isFavorite = false;
  bool descTextShowFlag = false;
  bool descTextShowFlag2 = false;

  late int totalSpaceTaken;
  late int totalSpace;

  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;

  late String textbody =
      "${widget.ngoName}\n${widget.ngoEvent.name}\n\n${widget.ngoEvent.description}\n\n$startDate $startTime\nto\n$endDate $endTime\n\n'${widget.ngoEvent.address}\n${widget.ngoEvent.city}, ${widget.ngoEvent.state} ${widget.ngoEvent.zip} ${widget.ngoEvent.country}\n\n${widget.ngoEvent.notes}\n\nSent from the Chodi App ";

  @override
  void initState() {
    favoriteList = FirebaseFirestore.instance
        .collection('Favorites')
        .doc(_auth.currentUser!.uid)
        .snapshots();

    registeredForList = FirebaseFirestore.instance
        .collection('EndUsers')
        .doc(_auth.currentUser!.uid)
        .snapshots();

    totalSpace = widget.ngoEvent.totalSpace;
    totalSpaceTaken = widget.ngoEvent.totalSpaceTaken;

    super.initState();
  }

  void _getDates(Timestamp startDateStamp, Timestamp endDateStamp) {
    startDate = DateFormat.yMMMMd().format(startDateStamp.toDate());
    endDate = DateFormat.yMMMMd().format(endDateStamp.toDate());

    startTime = DateFormat.jm().format(startDateStamp.toDate());
    endTime = DateFormat.jm().format(endDateStamp.toDate());
  }

  @override
  Widget build(BuildContext context) {
    var remainingSpace = totalSpace - totalSpaceTaken;
    log(remainingSpace.toString());
    return StreamBuilder(
        stream: CombineLatestStream.list([favoriteList, registeredForList]),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            try {
              var _isThere = snapshot.data[0]!
                  .get("Favorite Events")[widget.ngoEvent.eventID];
              if (_isThere != null) {
                _isFavorite = true;
              }
            } catch (e) {
              _isFavorite = false;
            }

            try {
              var _isRegistered = snapshot.data[1]!
                  .get("registeredFor")[widget.ngoEvent.eventID];

              if (_isRegistered != null) {
                _isMark = true;
              }
            } catch (e) {
              _isMark = false;
            }
          }
          _getDates(widget.ngoEvent.startTime, widget.ngoEvent.endTime);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Event Details',
                  style: TextStyle(color: Colors.black)),
              centerTitle: true,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(
                color: Colors.black, //修改颜色
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: CachedNetworkImage(
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                            imageUrl: widget.ngoEvent.imageURL!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.ngoName,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 5),
                              Text(widget.ngoEvent.name,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        _isMark ==
                                                true // Check if user has already registered for the event
                                            ? showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Registration'),
                                                    content: const Text(
                                                        'You are already registered for the event. Would you like to deregister?'),
                                                    actions: [
                                                      GestureDetector(
                                                        onTap: () =>
                                                            Navigator.pop(
                                                                context, 1),
                                                        child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 15),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(3),
                                                            child: const Text(
                                                                'Yes',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue))),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3),
                                                            child: Text(
                                                                'Cancel',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue))),
                                                      )
                                                    ],
                                                  );
                                                }).then((value) {
                                                if (value == 1) {
                                                  //remove from firebase

                                                  totalSpaceTaken--;
                                                  fbservice.deregisterForEvent(
                                                      widget.ngoEvent.eventID,
                                                      widget.ngoEIN,
                                                      totalSpaceTaken);
                                                  setState(() {
                                                    _isMark = false;
                                                  });
                                                }
                                              })
                                            : remainingSpace >
                                                    0 //User is not registered to an event yet and space is available
                                                ? showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Registration'),
                                                        content: remainingSpace >
                                                                1
                                                            ? Text(
                                                                'There are $remainingSpace spaces available.\nWould you like to register?')
                                                            : const Text(
                                                                'There is 1 space available.\nWould you like to register?'),
                                                        actions: [
                                                          GestureDetector(
                                                            onTap: () =>
                                                                Navigator.pop(
                                                                    context, 1),
                                                            child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            15),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(3),
                                                                child: const Text(
                                                                    'Yes',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue))),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(3),
                                                                child: Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue))),
                                                          )
                                                        ],
                                                      );
                                                    }).then((value) {
                                                    if (value == 1) {
                                                      //add to firebase
                                                      totalSpaceTaken++;

                                                      fbservice
                                                          .registerForEvent(
                                                              widget.ngoEvent
                                                                  .name,
                                                              widget.ngoEvent
                                                                  .eventID,
                                                              widget.ngoEIN,
                                                              totalSpaceTaken,
                                                              widget.ngoEvent
                                                                  .endTime);
                                                      setState(() {
                                                        _isMark = true;
                                                      });
                                                    }
                                                  })
                                                : showDialog(
                                                    //no space is available
                                                    context: context,
                                                    builder: (context) {
                                                      return const AlertDialog(
                                                        title: Text(
                                                            'Registration'),
                                                        content: Text(
                                                            'Sorry! There are currently no spaces available.'),
                                                      );
                                                    });
                                      },
                                      icon: _isMark
                                          ? const Icon(Icons.bookmark,
                                              color: Colors.yellow)
                                          : const Icon(Icons.bookmark_border)),
                                  const SizedBox(width: 5),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isShare = !_isShare;

                                          if (_isShare) {
                                            shareModal.shareModalSocialMedia(
                                                context, textbody);
                                          }
                                        });
                                      },
                                      icon: _isShare
                                          ? const Icon(Icons.share,
                                              color: Colors.blue)
                                          : const Icon(Icons.share)),
                                  const SizedBox(width: 5),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isFavorite = !_isFavorite;

                                          if (_isFavorite) {
                                            fbservice.addUserFavoriteEvent(
                                                widget.ngoEIN,
                                                widget.ngoEvent.eventID);
                                          } else {
                                            fbservice.removeUserFavoriteEvent(
                                                widget.ngoEvent.eventID);
                                          }
                                        });
                                      },
                                      icon: _isFavorite
                                          ? const Icon(Icons.favorite,
                                              color: Colors.red)
                                          : const Icon(Icons.favorite_border))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    const SizedBox(height: 10),
                    const Text('Description', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 20),
                    Text(widget.ngoEvent.description!,
                        maxLines: descTextShowFlag ? 200 : 5,
                        textAlign: TextAlign.start),
                    InkWell(
                      onTap: () {
                        setState(() {
                          descTextShowFlag = !descTextShowFlag;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          widget.ngoEvent.description != ''
                              ? descTextShowFlag
                                  ? const Text(
                                      "Show Less",
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  : const Text("Show More",
                                      style: TextStyle(color: Colors.blue))
                              : const SizedBox(height: 0),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text('Date', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text(
                        'Start Date: $startDate, $startTime \nEnd Date: $endDate, $endTime',
                        style: const TextStyle(fontSize: 15)),
                    const SizedBox(height: 30),
                    const Text('Location', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text(
                        '${widget.ngoEvent.address}\n${widget.ngoEvent.city}, ${widget.ngoEvent.state} ${widget.ngoEvent.zip} ${widget.ngoEvent.country}',
                        style: const TextStyle(fontSize: 15)),
                    const SizedBox(height: 30),
                    const Text('Notes', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text(widget.ngoEvent.notes!,
                        maxLines: descTextShowFlag2 ? 200 : 5,
                        textAlign: TextAlign.start),
                    InkWell(
                      onTap: () {
                        setState(() {
                          descTextShowFlag2 = !descTextShowFlag2;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          widget.ngoEvent.notes != ''
                              ? descTextShowFlag2
                                  ? const Text(
                                      "Show Less",
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  : const Text("Show More",
                                      style: TextStyle(color: Colors.blue))
                              : const SizedBox(height: 0),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    /*
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 30),
                        ElevatedButton(
                            onPressed: () => onButtonTap(Share.twitter),
                            child: const Text('share to twitter')),
                        ElevatedButton(
                          onPressed: () => onButtonTap(Share.facebook),
                          child: const Text('share to  FaceBook'),
                        ),
                        ElevatedButton(
                          onPressed: () => onButtonTap(Share.messenger),
                          child: const Text('share to  Messenger'),
                        ),
                        ElevatedButton(
                          onPressed: () => onButtonTap(Share.share_instagram),
                          child: const Text('share to Instagram'),
                        ),
                        *.
                      ],
                    ),*/
                  ],
                )),
              ),
            ),
          );
        });
  }
}
