// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/nonprofit_organization.dart';
import 'package:flutter_chodi_app/screens/impact/impact_screen.dart';
import 'package:flutter_chodi_app/services/firebase_authentication_service.dart';
import 'package:flutter_chodi_app/widget/recent_activity_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../models/activity.dart';
import '../../models/impact.dart';
import '../../viewmodel/main_view_model.dart';

FirebaseService fbservice = FirebaseService();

class RecentActivityScreen extends StatefulWidget {
  List<Impact> impact;
  // ignore: non_constant_identifier_names
  List<NonProfitOrg> NgoList;
  RecentActivityScreen({
    Key? key,
    required this.impact,
    // ignore: non_constant_identifier_names
    required this.NgoList,
  }) : super(key: key);

  @override
  State<RecentActivityScreen> createState() => _RecentActivityScreen();
}

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

class _RecentActivityScreen extends State<RecentActivityScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    log(widget.impact.length.toString());
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10, left: 16, right: 16),
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
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Text(
                "Recent Activity",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Expanded(
              child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Column(
                children: _createRecentActivityWidget(
                    widget.impact.length, widget.impact, widget.NgoList)),
          ))
        ],
      ),
    );
  }
}

/*
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