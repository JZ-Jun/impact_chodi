// ignore_for_file: camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/nonprofit_organization.dart';
import 'package:flutter_chodi_app/screens/foryou/contact_page.dart';
import 'package:flutter_chodi_app/screens/foryou/donate_page.dart';
import 'package:flutter_chodi_app/screens/foryou/event_page.dart';

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
  bool isFavorite = false;
  bool descTextShowFlag = false;

  @override
  Widget build(BuildContext context) {
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
                  child: FittedBox(
                    child: Text(widget.ngoInfo.name,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
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
            const SizedBox(height: 15),
            getInfoItem(widget.ngoInfo.contactNumber!, Icons.phone),
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
                            getInfoItem("Location: ${widget.ngoInfo.state!}",
                                Icons.place),
                            getInfoItem(
                                'Categories: ${widget.ngoInfo.category}',
                                Icons.equalizer),
                            getInfoItem(
                                'Year Founded: ${widget.ngoInfo.founded!}',
                                Icons.event),
                            getInfoItem('Size: ${widget.ngoInfo.orgSize}',
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      alignment: Alignment.center,
                      child: const Text('EVENT'),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
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
                  descTextShowFlag
                      ? const Text(
                          "Show Less",
                          style: TextStyle(color: Colors.blue),
                        )
                      : const Text("Show More",
                          style: TextStyle(color: Colors.blue))
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
  }

  getInfoItem(String txt, IconData iconData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(iconData, size: 25),
        const SizedBox(width: 15),
        Text(txt)
      ],
    );
  }
}
