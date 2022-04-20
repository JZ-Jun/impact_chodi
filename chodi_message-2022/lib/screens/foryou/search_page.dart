import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firestore_search/firestore_search.dart';

import 'package:flutter_chodi_app/models/nonprofit_organization.dart';
import 'package:flutter_chodi_app/screens/foryou/detail_page.dart';

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
  List<NonProfitOrg> searchList = []; //include only search results

  String? get _errorText {
    final text = _searchController.value.text;

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*
    return FirestoreSearchScaffold(
      firestoreCollectionName: 'Nonprofits',
      searchBy: 'Name',
      scaffoldBody: const Center(child: Text("No results")),
      dataListFromSnapshot: NonProfitOrg().dataListFromSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<NonProfitOrg>? dataList = snapshot.data;
          if (dataList!.isEmpty) {
            return const Center(
              child: Text('No Results Returned'),
            );
          }
          return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final NonProfitOrg data = dataList[index];

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.name!,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, left: 8.0, right: 8.0),
                      child: Text('add data',
                          style: Theme.of(context).textTheme.bodyText1),
                    )
                  ],
                );
              });
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Results Returned'),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    */

    return ValueListenableBuilder(
        valueListenable: _searchController,
        builder: (context, TextEditingValue value, __) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Search'),
              backgroundColor: Colors.grey.shade400,
            ),
            body: Container(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 0, bottom: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              labelText: 'Search for organizations...',
                              errorText: _errorText),
                        ),
                      ),
                      Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  //reset searchList
                                  searchList = [];

                                  for (var i in widget.ngoList) {
                                    if (i.name!.toLowerCase().contains(
                                        _searchController.text.toLowerCase())) {
                                      searchList.add(i);

                                      log(i.name!);
                                    }
                                  }
                                },
                              ))),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  buildItem(NonProfitOrg ngo) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Detail_Page(ngoInfo: ngo);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                height: 110,
                child: CachedNetworkImage(
                  imageUrl: ngo.imageURL!, //testing image
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Expanded(
                  child: Container(
                width: 120,
                alignment: Alignment.centerLeft,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(left: 5),
                child: Text(ngo.name!, style: const TextStyle(fontSize: 10)),
              ))
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
