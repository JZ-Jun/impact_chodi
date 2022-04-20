import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/foryou/search_page.dart';
import 'package:flutter_chodi_app/widget/SwiperPagination.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/nonprofit_organization.dart';
import '../../services/user_location.dart';

import 'community_page.dart';
import 'detail_page.dart';
import 'interest_page.dart';

import 'dart:developer';

class ForYouScreen extends StatefulWidget {
  const ForYouScreen({Key? key}) : super(key: key);

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  UserLocation userLocation = UserLocation();
  late Stream dataList;

  late Stream featured1;
  late Stream featured2;
  late Stream featured3;
  late Stream featured4;

  @override
  void initState() {
    super.initState();

    dataList = FirebaseFirestore.instance
        .collection("Nonprofits")
        .orderBy("Name", descending: false)
        .snapshots();

    //individual Firestore queries
    featured1 = FirebaseFirestore.instance
        .collection("Nonprofits")
        .where("Name", isEqualTo: "LA FOOD BANK")
        .limit(1)
        .snapshots();

    featured2 = FirebaseFirestore.instance
        .collection("Nonprofits")
        .where("Name", isEqualTo: "All About The Animals")
        .limit(1)
        .snapshots();

    featured3 = FirebaseFirestore.instance
        .collection("Nonprofits")
        .where("Name", isEqualTo: "The Rescue Animal Santuary Inc.")
        .limit(1)
        .snapshots();

    featured4 = FirebaseFirestore.instance
        .collection("Nonprofits")
        .where("Name", isEqualTo: "Make A Wish Foundation of Greater Bay Area")
        .limit(1)
        .snapshots();
  }

  //stores data for the nonprofit organization
  List<NonProfitOrg> ngoList = [];

  //store interest data based on user data?
  //build recommendations system based on possibly organizations supported
  //choose organizations with same categories?
  List<NonProfitOrg> interestList = [];

  //stores data for the swiper
  List<NonProfitOrg> bannerList = [];

  _buildSwiper() {
    return StreamBuilder<dynamic>(
        stream: CombineLatestStream.list(
            [featured1, featured2, featured3, featured4]),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Container();
          } else {
            //Iterate through all 4 combined streams
            for (int index = 0; index < snapshot.data.length; index++) {
              for (var i in snapshot.data[index].docs) {
                bannerList.add(NonProfitOrg.fromFirestore(i));
              }
            }

            return Container(
              color: Colors.transparent,
              child: SizedBox.fromSize(
                size: const Size.fromHeight(170),
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: CachedNetworkImage(
                          imageUrl: bannerList[index].imageURL!, //testing image
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Detail_Page(ngoInfo: bannerList[index]);
                        }));
                      },
                    );
                  },
                  pagination: SwiperPagination(
                      margin: const EdgeInsets.only(bottom: 0),
                      builder: CustomRectSwiperPaginationBuilder(
                          color: Colors.grey.shade300,
                          activeColor: Colors.grey,
                          sizeW: 15,
                          sizeH: 15,
                          activeSizeW: 15,
                          activeSizeH: 15,
                          space: 5)),
                  loop: true,
                  autoplayDelay: 4000,
                  itemCount: bannerList.length,
                  control: null,
                  duration: 2000,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1,
                  autoplay: true,
                ),
              ),
            );
          }
        });
  }

  Future _updateNearby({double dist = 10}) async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double lat = 0.0144927536231884;
    double lon = 0.0181818181818182;
    double distance = dist; //measurement should be around miles
    double lowerLat = position.latitude - (lat * distance);
    double lowerLon = position.longitude - (lon * distance);
    double greaterLat = position.latitude + (lat * distance);
    double greaterLon = position.longitude + (lon * distance);
    GeoPoint lesserGeopoint = GeoPoint(lowerLat, lowerLon);
    GeoPoint greaterGeopoint = GeoPoint(greaterLat, greaterLon);
    dataList = FirebaseFirestore.instance
        .collection("Nonprofits")
        .where("Coordinates", isGreaterThan: lesserGeopoint)
        .where("Coordinates", isLessThan: greaterGeopoint)
        .snapshots();
  }

//enable nearby nonprofits
  Widget _updateNearbyNonprofitsButton() {
    return OutlinedButton.icon(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 14),
          padding: const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 10),
        ),
        onPressed: () {
          setState(() {
            //update if service enabled
            userLocation.determinePosition().then((res) {
              _updateNearby(dist: 40);
            });
          });
        },
        icon: const Icon(Icons.location_on),
        label: const Text('Locate Nearby Nonprofits'));
  }

  _clearList() {
    ngoList.clear();
    bannerList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dataList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Container();
          } else {
            //_called when rebuilding
            _clearList();

            for (var i in snapshot.data!.docs) {
              ngoList.add(NonProfitOrg.fromFirestore(i));
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
                      Text('O',
                          style: TextStyle(fontSize: 25, color: Colors.red)),
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const search_page();
                          }));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.search),
                        ))
                  ],
                ),
                body: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _updateNearbyNonprofitsButton(),
                      const Text('Featured',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _buildSwiper(),
                      const SizedBox(height: 10),
                      Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      const Text('Explore Your Community',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text(
                          'Support and empower nonprofits around your local area. Be the change in your community!'),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return buildItem(ngoList[index]);
                            },
                            itemCount: ngoList.length,
                            scrollDirection: Axis.horizontal),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return community_page(
                                ngoList: ngoList,
                              );
                            }));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text('More',
                                  style: TextStyle(color: Colors.blue)),
                              SizedBox(width: 5),
                              Icon(Icons.chevron_right, color: Colors.blue)
                            ],
                          )),
                      const SizedBox(height: 5),
                      Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      const Text('Based on your interests',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return buildItem(ngoList[index]);
                            },
                            itemCount: ngoList.length,
                            scrollDirection: Axis.horizontal),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return interest_page(communityNgoList: ngoList);
                            }));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text('More',
                                  style: TextStyle(color: Colors.blue)),
                              SizedBox(width: 5),
                              Icon(Icons.chevron_right, color: Colors.blue)
                            ],
                          )),
                      const SizedBox(height: 10),
                    ],
                  )),
                ));
          }
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
}
