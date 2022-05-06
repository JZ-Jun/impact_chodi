import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/activity.dart';
import 'package:flutter_chodi_app/models/impact.dart';
import 'package:flutter_chodi_app/models/nonprofit_organization.dart';
import 'package:flutter_chodi_app/screens/impact/organization_screen.dart';
import 'package:flutter_chodi_app/screens/impact/performance/performance_screen.dart';
import 'package:flutter_chodi_app/screens/impact/recent_activity_screen.dart';
import 'package:flutter_chodi_app/services/firebase_authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chodi_app/services/firebase_storage_service.dart';
import 'package:flutter_chodi_app/services/google_authentication_service/log_out_button.dart';
import 'package:flutter_chodi_app/viewmodel/main_view_model.dart';
import 'package:flutter_chodi_app/widget/organization_widget.dart';
import 'package:flutter_chodi_app/widget/profile_avatar.dart';
import 'package:flutter_chodi_app/widget/recent_activity_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widget/clock/analog_clock.dart';

/*FirebaseService fbservice = FirebaseService();
Storage storage = Storage();
late Future recentHistoryData;
late Future supportedOrganizationsData;
late Future organizationImageURLs;*/

class ImpactScreen extends StatefulWidget {
  const ImpactScreen({Key? key}) : super(key: key);

  @override
  State<ImpactScreen> createState() => _ImpactScreenState();
}

/*RecentAmount imposes a cap on the amount of data that can be read at once (so that we don't
read all the data*/
/*Future<List<dynamic>> _getRecentHistoryDataImpact(recentAmount,

    [dataField]) async {
  List<dynamic> dataList = []; //contain entire dataset for the collection
  List<dynamic> recentHistoryDataList =
      []; //contain information for recentActivityWidget
  int totalDonations = 0;
  int totalHours = 0;
  int totalParticipatedEvents = 0;

  if (dataField == 'assetURL') {
  } else {
    await fbservice.getUserRecentHistoryData().then((res) => {
          totalParticipatedEvents = res.length,
          dataList = res,
          for (var i = 0; i < res.length; i++)
            {
              if (res[i]['action'] == 'donation')
                {totalDonations += int.parse(res[i]['donated'])}
              else if (res[i]['action'] == 'volunteer')
                {
                  {totalHours += int.parse(res[i]['donated'])}
                }
            }
        });
  }

  //Cap on getting activity
  for (int i = 0; i < dataList.length; i++) {
    if (i < recentAmount) {
      await storage.downloadURL(dataList[i]['assetURL']).then((res) => {
            recentHistoryDataList.add(
              [dataList[i]['organizationName'], res],
              //["World Concern", assetURL]
            )
          });
    }
  }

  return [
    dataList,
    totalDonations,
    totalHours,
    totalParticipatedEvents,
    recentHistoryDataList
  ];
}*/

/*//support function for other functions
Future<List<dynamic>> _getSupportedOrganizations([dataField]) async {
  List<dynamic> listURL = [];

  await fbservice.getUserSupportedOrganizationsData().then((res) async => {
        if (dataField == 'assetURL')
          {
            for (int i = 0; i < res.length; i++)
              {
                await storage.downloadURL(res[i]['assetURL']).then((res2) => {
                      listURL.add({
                        'organization': [res[i]["organizationName"], res2]
                      })
                      //"organization" : [World Concern, imageDownloadURL]
                    })
              }
          }
      });

  return listURL;

}*/

//navigate to detail_page.dart later
List<Widget> _createOrganizationWidget(
    BuildContext context, List<Impact>? impacts, List<NonProfitOrg> NGOs) {
  var avatars = <Widget>[];

  if (impacts != null) {
    if (impacts.isEmpty) {
      avatars.add(const Text(''));
    } else {
      print(impacts);
      for (var i = 0; i < impacts.length; i++) {
        if (i < 4) {
          print(NGOs);
          avatars.add(ProfileAvatar(assetURL: NGOs[i].returnImpactImageURL()));
        } else {
          break;
        }
      }
    }
  }

  avatars.add(GestureDetector(
    onTap: () {
      Provider.of<MainScreenViewModel>(context, listen: false)
          .setWidget(const OrganizationScreen());
    },
    child: SvgPicture.asset(
      "assets/svg/arrow_right.svg",
      width: 15,
      height: 15,
    ),
  ));

  return avatars;
}

//navigate to event_detail_page

List<Widget> _createRecentActivityWidget(
    recentAmount, List<Impact> impactList, List<NonProfitOrg> NGOs) {
  var list = <Widget>[];
  String activityResults = '';
  String date = '';

  //retrieve data and hours/minutes from firebase
  if (impactList != null) {
    for (var i = 0; i < impactList.length; i++) {
      if (i < recentAmount) {
        date = DateFormat.yMMMd().format(impactList[i].returnDate().toDate());
        if (impactList[i].isEvent == true) {
          activityResults = impactList[i].returnHours().toString() + ' hours';
        } else if (impactList[i].isEvent == false) {
          activityResults =
              impactList[i].returnDonations().toString() + ' dollars';
        }

        if (i == 0) {
          list.add(Padding(
            padding: const EdgeInsets.all(0),
            child: RecentActivityWidget(
                activity: Activity(
                    getNonProfit(NGOs, impactList[i].returnEIN())
                        .returnImpactImageURL(),
                    getNonProfit(NGOs, impactList[i].returnEIN()).returnName(),
                    activityResults,
                    date)),
          ));
        } else {
          list.add(Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RecentActivityWidget(
                activity: Activity(
                    getNonProfit(NGOs, impactList[i].returnEIN())
                        .returnImpactImageURL(),
                    getNonProfit(NGOs, impactList[i].returnEIN()).returnName(),
                    activityResults,
                    date)),
          ));
        }
      }
    }
  }

  return list;
}

class _ImpactScreenState extends State<ImpactScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  late Stream impactList;
  late Stream allNGOs;

  //late final Future allData;
  //String totalEventsParticipatedIn = '';

  @override
  void initState() {
    super.initState();

    String? uid = FirebaseAuth.instance.currentUser?.uid;

    print(uid);

    //Grab the user information
    impactList = FirebaseFirestore.instance
        .collection("EndUsers")
        //.doc("SM5W6pnRdqMgQW1znKusvHXpjHT2")
        .doc(uid)
        .collection("History")
        .orderBy("date", descending: true)
        .snapshots();

    allNGOs = FirebaseFirestore.instance.collection("Nonprofits").snapshots();

    /*recentHistoryData = _getRecentHistoryDataImpact(10); //START AT 10

    supportedOrganizationsData = _getSupportedOrganizations();
    organizationImageURLs = _getSupportedOrganizations('assetURL');*/

/*    allData = Future.wait(
      [
        recentHistoryData,
        supportedOrganizationsData,
        organizationImageURLs,
        //_getTotalParticipatedEvents(),
        //_getOrganizationWidget(context),
      ],
    );*/

    controller = AnimationController(
      duration: const Duration(milliseconds: 1300),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() => {});
      });
    controller.forward();
  }

  //stores data for each impact event the user has participated in
  List<Impact> Impacts = [];
  List<NonProfitOrg> NGOList = [];
  num totalDonations = 0;
  int totalHours = 0;
  int eventsJoined = 0;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: impactList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Container();
          } else {
            Impacts.clear();
            num totalDonations = 0;
            num totalHours = 0;
            int eventsJoined = 0;

            //add the impact events to a list we can more easily manipulate
            for (var i in snapshot.data!.docs) {
              //print(snapshot.data!.docs) ;
              Impacts.add(Impact.fromFirestore(i));
              //print(Impacts) ;
            }

            //figure out how many dollarydoos the user has donated
            for (int i = 0; i < Impacts.length; i++) {
              totalDonations += Impacts[i].returnDonations();
            }
            //figure out how many hours the user has donated
            for (int i = 0; i < Impacts.length; i++) {
              totalHours += Impacts[i].returnHours();
            }
            //figure out how many different events the user has been in
            for (int i = 0; i < Impacts.length; i++) {
              if (Impacts[i].returnIsEvent() == true) {
                eventsJoined++;
              }
            }

            return StreamBuilder(
                stream: allNGOs,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Container();
                  } else if (snapshot.hasData) {
                    NGOList.clear();

                    for (var i in snapshot.data!.docs) {
                      NGOList.add(NonProfitOrg.fromFirestore(i));
                    }
                  }

                  return Scaffold(
                      body: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 10,
                        left: 16,
                        right: 16),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Hi there",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            AnalogClock(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2.0, color: Colors.black),
                                  color: Colors.transparent,
                                  shape: BoxShape.circle),
                              width: 100.0,
                              height: 100.0,
                              isLive: true,
                              hourHandColor: Colors.black,
                              minuteHandColor: Colors.black,
                              showSecondHand: true,
                              numberColor: Colors.black87,
                              showNumbers: true,
                              showAllNumbers: true,
                              textScaleFactor: 1.4,
                              showTicks: true,
                              showDigitalClock: false,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text(
                                (totalHours * animation.value)
                                    .toInt()
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Hours donated"),
                            ),
                            // '\$${h}',
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                "\$${(totalDonations * animation.value).toInt().toString()}",
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Volunteer dollars donated"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 26),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Text("Organizations You Support"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: _createOrganizationWidget(
                                      context, Impacts, NGOList)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 22, bottom: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Text("Recent Activity"),
                              ),
                            ),

                            Column(
                                children: _createRecentActivityWidget(
                                    2, Impacts, NGOList)),

                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: GestureDetector(
                                onTap: () {
                                  Provider.of<MainScreenViewModel>(this.context,
                                          listen: false)
                                      .setWidget(RecentActivityScreen(
                                    list: snapshot.data[0][0],
                                    URLList: snapshot.data[0][4],
                                  ));
                                },
                                child: Row(
                                  children: [
                                    const Expanded(child: SizedBox()),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 6),
                                      child: Text("More",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF0000FF))),
                                    ),
                                    SvgPicture.asset(
                                      "assets/svg/arrow_right.svg",
                                      width: 13,
                                      height: 13,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Row(
                                children: [
                                  const Text(
                                    "What you’ve done",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  GestureDetector(
                                      onTap: () {
                                        Provider.of<MainScreenViewModel>(
                                                this.context,
                                                listen: false)
                                            .setWidget(PerformanceScreen());
                                      },
                                      child: const Text(
                                        "See Performance",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF0000FF)),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Text("Donated"),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    (totalDonations * animation.value)
                                        .toInt()
                                        .toString(),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: Row(
                                children: [
                                  const Text("Participated Event"),
                                  const Expanded(child: SizedBox()),
                                  Text(eventsJoined.toString())
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
                });
          }
        });

    /*  return FutureBuilder(
        future: allData,
        builder: ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return Scaffold(
                body: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 16,
                  right: 16),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Hi there",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      AnalogClock(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2.0, color: Colors.black),
                            color: Colors.transparent,
                            shape: BoxShape.circle),
                        width: 100.0,
                        height: 100.0,
                        isLive: true,
                        hourHandColor: Colors.black,
                        minuteHandColor: Colors.black,
                        showSecondHand: true,
                        numberColor: Colors.black87,
                        showNumbers: true,
                        showAllNumbers: true,
                        textScaleFactor: 1.4,
                        showTicks: true,
                        showDigitalClock: false,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 3),
                        child: Text(
                          "Hours Volunteered",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          (68713 * animation.value).toInt().toString(),
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 3),
                        child: Text(
                          "Donated",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/dollar.png',
                              width: 23,
                              height: 23,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 5, right: 23),
                                child: Text(
                                  "${(56489 * animation.value).toInt().toString()}",
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 26),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const Text("Organizations You Support"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/img.png',
                                height: 45,
                                width: 45,
                                fit: BoxFit.fill,
                              ),
                            ),
                            ClipOval(
                              child: Image.asset(
                                'assets/images/img.png',
                                height: 45,
                                width: 45,
                                fit: BoxFit.fill,
                              ),
                            ),
                            ClipOval(
                              child: Image.asset(
                                'assets/images/img.png',
                                height: 45,
                                width: 45,
                                fit: BoxFit.fill,
                              ),
                            ),
                            ClipOval(
                              child: Image.asset(
                                'assets/images/img.png',
                                height: 45,
                                width: 45,
                                fit: BoxFit.fill,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print("object");
                                Provider.of<MainScreenViewModel>(this.context,
                                        listen: false)
                                    .setWidget(const OrganizationScreen());
                              },
                              child: SvgPicture.asset(
                                "assets/svg/arrow_right.svg",
                                width: 15,
                                height: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22, bottom: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const Text("Recent Activity"),
                        ),
                      ),
                      RecentActivityWidget(
                          activity: Activity("assets/images/img_1.png",
                              "Autism Speaks", "3 hours", "Oct 25, 2021")),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: RecentActivityWidget(
                            activity: Activity("assets/images/img_2.png",
                                "World Concern", "3 hours", "Oct 25, 2021")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<MainScreenViewModel>(this.context,
                                    listen: false)
                                .setWidget(RecentActivityScreen());
                          },
                          child: Row(
                            children: [
                              const Expanded(child: SizedBox()),
                              const Padding(
                                padding: EdgeInsets.only(right: 6),
                                child: Text("More",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF0000FF))),
                              ),
                              SvgPicture.asset(
                                "assets/svg/arrow_right.svg",
                                width: 13,
                                height: 13,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: [
                            const Text(
                              "What you’ve done",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const Expanded(child: SizedBox()),
                            GestureDetector(
                                onTap: () {
                                  Provider.of<MainScreenViewModel>(this.context,
                                          listen: false)
                                      .setWidget(PerformanceScreen());
                                },
                                child: const Text(
                                  "See Performance",
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFF0000FF)),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            const Text("Donated"),
                            const Expanded(child: SizedBox()),
                            Text(
                              "\$${(880 * animation.value).toInt().toString()}",
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 26),
                        child: Row(
                          children: const [
                            Text("Participated Event"),
                            Expanded(child: SizedBox()),
                            Text(
                              "9",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
          }
        }));*/
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
