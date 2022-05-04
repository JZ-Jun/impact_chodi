// ignore_for_file: camel_case_types, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/nonprofit_organization.dart';

import 'detail_page.dart';

class community_page extends StatefulWidget {
  List<NonProfitOrg> ngoList = [];

  community_page({Key? key, required this.ngoList}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return community_page_state();
  }
}

class community_page_state extends State<community_page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {}

          return Scaffold(
            appBar: AppBar(
              title: const Text('Communities'),
              elevation: 0,
              backgroundColor: Colors.grey.shade400,
            ),
            body: Container(
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //横轴元素个数
                      crossAxisCount: 2,
                      //纵轴间距
                      mainAxisSpacing: 10.0,
                      //横轴间距
                      crossAxisSpacing: 10.0,
                      //子组件宽高长度比例
                      childAspectRatio: 1.0),
                  itemBuilder: (context, index) {
                    return buildItem(index);
                  },
                  itemCount: widget.ngoList.length),
            ),
          );
        });
  }

  buildItem(int index) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Detail_Page(
              ngoInfo: widget.ngoList[index],
            );
          }));
        },
        child: Container(
          margin: const EdgeInsets.only(left: 5, top: 10, right: 5),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.grey),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 2.0,
                    spreadRadius: 1.0)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 140,
                child: CachedNetworkImage(
                  imageUrl: widget.ngoList[index].imageURL!, //testing image
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(left: 5),
                child: Text(widget.ngoList[index].name,
                    style: const TextStyle(fontSize: 10)),
              ))
            ],
          ),
        ));
  }
}
