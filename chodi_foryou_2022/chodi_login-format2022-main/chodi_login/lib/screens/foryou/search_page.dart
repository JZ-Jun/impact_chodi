import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/nonprofit_organization.dart';
import 'package:flutter_chodi_app/screens/foryou/detail_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class search_page extends StatefulWidget {
  List<NonProfitOrg> ngoList = [];

  search_page({Key? key, required this.ngoList}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return search_page_state();
  }
}

// ignore: camel_case_types
class search_page_state extends State<search_page> {
  final _searchController = TextEditingController();
  final scrollController = ScrollController();

  List<NonProfitOrg> searchList = []; //include only search results

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _searchController,
        builder: (context, TextEditingValue value, __) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Search'),
                elevation: 0,
                backgroundColor: Colors.grey.shade400,
              ),
              body: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 0, bottom: 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  labelText: 'Search for organizations...',
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed: () {
                                          searchList.clear();
                                          //reset searchList
                                          if (_searchController.text.isEmpty) {
                                            _showToast('Can\'t be empty');
                                          } else {
                                            for (var i in widget.ngoList) {
                                              if (i.name!
                                                  .toLowerCase()
                                                  .contains(_searchController
                                                      .text
                                                      .toLowerCase())) {
                                                searchList.add(i);
                                              }
                                            }
                                          }
                                        }))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      child: searchList.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.all(15),
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10.0,
                                          crossAxisSpacing: 10.0,
                                          childAspectRatio: 1.0),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return buildItem(index);
                                  },
                                  itemCount: searchList.length),
                            )
                          : const Center(child: Text('No Results Found'))),
                ],
              ));
        });
  }

  buildItem(int index) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Detail_Page(
              ngoInfo: searchList[index],
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
                  imageUrl: searchList[index].imageURL!, //testing image
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
                child: Text(searchList[index].name!,
                    style: const TextStyle(fontSize: 10)),
              ))
            ],
          ),
        ));
  }

  _showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xFF76D6E1),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
