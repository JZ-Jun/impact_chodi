import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/event.dart';
import 'package:intl/intl.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';

// ignore: camel_case_types, must_be_immutable
class event_detail_page extends StatefulWidget {
  Event ngoEvent;
  String ngoName;

  event_detail_page({Key? key, required this.ngoEvent, required this.ngoName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return event_detail_page_state();
  }
}

// ignore: camel_case_types
class event_detail_page_state extends State<event_detail_page> {
  bool _isMark = false;
  bool _isShare = false;
  bool _isFavorite = false;
  bool descTextShowFlag = false;

  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;

  @override
  void initState() {
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
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
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
            body: Container(
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
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Registration'),
                                              content: Text(
                                                  'There are 50 spaces available.\nWould you like to register?'),
                                              actions: [
                                                GestureDetector(
                                                  onTap: () =>
                                                      Navigator.pop(context, 1),
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      child: const Text('Yes',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blue))),
                                                ),
                                                GestureDetector(
                                                  onTap: () =>
                                                      Navigator.pop(context),
                                                  child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(3),
                                                      child: Text('Cancel',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blue))),
                                                )
                                              ],
                                            );
                                          }).then((value) {
                                        if (value == 1) {
                                          setState(() {
                                            _isMark = !_isMark;
                                          });
                                        }
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: Text('map'),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              )),
            ),
          );
        });
  }
}
