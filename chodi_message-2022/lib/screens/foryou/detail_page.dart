// ignore_for_file: camel_case_types, unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/nonprofit_organization.dart';
import 'package:flutter_chodi_app/screens/foryou/contact_page.dart';
import 'package:flutter_chodi_app/screens/foryou/donate_page.dart';
import 'package:flutter_chodi_app/screens/foryou/event_page.dart';
import 'package:flutter_chodi_app/services/firebase_authentication_service.dart';

// ignore: must_be_immutable
class Detail_Page extends StatefulWidget {
  //contain all info about the nonprofit organization
  NonProfitOrg ngoInfo;

  Detail_Page({Key? key, required this.ngoInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Detail_Page_State();
  }
}

class Detail_Page_State extends State<Detail_Page> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseService fbservice = FirebaseService();
  bool _isFavorite = false;
  bool descTextShowFlag = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Favorites')
            .doc(_auth.currentUser!.uid)
            .snapshots(), //query to user's favorite list and see if the EIN is in there and set isFavorite = true if found
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            for (var i in snapshot.data!.get('Favorite Organizations')) {
              if (i == widget.ngoInfo.ein) {
                _isFavorite = true;
              }
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text(''),
              backgroundColor: Colors.grey.shade400,
            ),
            body: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(widget.ngoInfo.name!,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isFavorite = !_isFavorite;

                              if (_isFavorite) {
                                //add to firebase
                                fbservice.addUserFavoriteOrganizationData(
                                    widget.ngoInfo.ein);
                              } else {
                                //remove from firebase
                                fbservice.removeUserFavoriteOrganizationData(
                                    widget.ngoInfo.ein);
                              }
                            });
                          },
                          icon: _isFavorite
                              ? const Icon(Icons.favorite, color: Colors.red)
                              : const Icon(Icons.favorite_border))
                    ],
                  ),
                  const SizedBox(height: 15),
                  getInfoItem('', widget.ngoInfo.contactNumber!, Icons.phone),
                  Row(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: CachedNetworkImage(
                          imageUrl: widget.ngoInfo.imageURL!, //testing image
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Expanded(
                          child: Container(
                              padding: const EdgeInsets.only(left: 12),
                              child: Column(
                                children: [
                                  getInfoItem('Location:',
                                      widget.ngoInfo.state!, Icons.place),
                                  getInfoItem('Categories:',
                                      widget.ngoInfo.category, Icons.equalizer),
                                  getInfoItem('Year Founded:',
                                      widget.ngoInfo.founded!, Icons.event),
                                  getInfoItem('Size:', widget.ngoInfo.orgSize,
                                      Icons.perm_identity)
                                ],
                              )))
                    ],
                  ),
                  const SizedBox(height: 25),
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            alignment: Alignment.center,
                            child: const Text('DONATE'),
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            alignment: Alignment.center,
                            child: const Text('EVENT'),
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return contact_page(
                                  contactEmail: widget.ngoInfo.contactEmail!);
                            }));
                          },
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            alignment: Alignment.center,
                            child: const Text('CONTACT'),
                          ))
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 15),
                  const Text('INFO',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Text(widget.ngoInfo.vision!,
                          maxLines: descTextShowFlag ? 50 : 4,
                          textAlign: TextAlign.start),
                    ),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      setState(() {
                        descTextShowFlag = !descTextShowFlag;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        widget.ngoInfo.vision != ''
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
                  const SizedBox(height: 5),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 15),
                  const Text('Website',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(widget.ngoInfo.website!,
                      style: const TextStyle(color: Colors.blue))
                ],
              ),
            ),
          );
        });
  }

  getInfoItem(String txt, dynamic data, IconData iconData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(iconData, size: 25),
        const SizedBox(width: 15),
        data != '' && data != 0
            ? Text('${txt} ${data}')
            : Text('${txt} unknown')
      ],
    );
  }
}
