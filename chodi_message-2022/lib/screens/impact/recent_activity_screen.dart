// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/impact/impact_screen.dart';
import 'package:flutter_chodi_app/services/firebase_authentication_service.dart';
import 'package:flutter_chodi_app/services/firebase_storage_service.dart';
import 'package:flutter_chodi_app/widget/recent_activity_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../models/activity.dart';
import '../../viewmodel/main_view_model.dart';

class RecentActivityScreen extends StatelessWidget {
  const RecentActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];
    list.add(RecentActivityWidget(
        activity: Activity("assets/images/img_1.png", "Autism Speaks",
            "3 hours", "Oct 25, 2021")));

    list.add(RecentActivityWidget(
        activity: Activity("assets/images/img_2.png", "World Concern",
            "3 hours", "Oct 25, 2021")));
    return StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                left: 16,
                right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Image.asset(
                    "assets/images/back.png",
                    height: 40,
                    width: 40,
                    fit: BoxFit.fill,
                  ),
                  onTap: () {
                    Provider.of<MainScreenViewModel>(context, listen: false)
                        .setWidget(const ImpactScreen());
                  },
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      "Recent Activity",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.only(
                                    top: 12, left: 3, right: 3),
                                child: list[index]);
                          },
                          itemCount: list.length,
                        )))
              ],
            ),
          );
        });
  }
}

/*
FirebaseService fbservice = FirebaseService();
Storage storage = Storage();
late List activityList = [];
late List activityURLList = [];

class RecentActivityScreen extends StatefulWidget {
  List<dynamic> list = [];
  List<dynamic> URLList = [];
  RecentActivityScreen({Key? key, required this.list, required this.URLList})
      : super(key: key);

  @override
  State<RecentActivityScreen> createState() => _RecentActivityScreen();
}

List<Widget> _createRecentActivityWidget(recentAmount,
    [List<dynamic>? recentList, List<dynamic>? recentURLList]) {
  var list = <Widget>[];
  String activityResults = '';
  String date = '';

  //retrieve data and hours/minutes from firebase
  if (recentList != null && recentURLList != null) {
    for (var i = 0; i < recentList.length; i++) {
      if (i < recentAmount) {
        date = DateFormat.yMMMd().format(recentList[i]['date'].toDate());
        if (recentList[i]['action'] == 'volunteer') {
          if (int.parse(recentList[i]['donated']) < 1) {
            activityResults = recentList[i]['donated'] + ' minutes';
          } else {
            activityResults = recentList[i]['donated'] + ' hours';
          }
        } else if (recentList[i]['action'] == 'donation') {
          activityResults = recentList[i]['donated'] + ' dollars';
        }

        if (i == 0) {
          list.add(Padding(
            padding: const EdgeInsets.all(0),
            child: RecentActivityWidget(
                activity: Activity(recentURLList[i][1],
                    recentList[i]['organizationName'], activityResults, date)),
          ));
        } else {
          list.add(Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RecentActivityWidget(
                activity: Activity(recentURLList[i][1],
                    recentList[i]['organizationName'], activityResults, date)),
          ));
        }
      }
    }
  }

  return list;
}



class _RecentActivityScreen extends State<RecentActivityScreen> {
  @override
  void initState() {
    super.initState();
    activityList = widget.list;
    activityURLList = widget.URLList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: ((context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Container();
      } else {
        return Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 16,
              right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Image.asset(
                  "assets/images/back.png",
                  height: 40,
                  width: 40,
                  fit: BoxFit.fill,
                ),
                onTap: () {
                  Provider.of<MainScreenViewModel>(context, listen: false)
                      .setWidget(ImpactScreen());
                },
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "Recent Activity",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Expanded(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  top: 12, left: 3, right: 3),
                              child: _createRecentActivityWidget(
                                  9, activityList, activityURLList)[index]);
                        },
                        itemCount: _createRecentActivityWidget(
                                9, activityList, activityURLList)
                            .length,
                      )))
            ],
          ),
        );
      }
    }));
  }
}
*/
