import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/impact/impact_screen.dart';
import 'package:flutter_chodi_app/widget/recent_activity_widget.dart';
import 'package:provider/provider.dart';

import '../../models/activity.dart';
import '../../viewmodel/main_view_model.dart';

class RecentActivityScreen extends StatelessWidget {
  const RecentActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];
    list.add(RecentActivityWidget(
        activity: Activity("assets/images/img_1.png",
            "Autism Speaks", "3 hours", "Oct 25, 2021")));

    list.add(RecentActivityWidget(
        activity: Activity("assets/images/img_2.png",
            "World Concern", "3 hours", "Oct 25, 2021")));
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .padding
              .top + 10, left: 16, right: 16),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Expanded(
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                          padding:
                          const EdgeInsets.only(top: 12, left: 3, right: 3),
                          child:list[index]
                      );
                    },
                    itemCount: list.length,
                  )))
        ],
      ),
    );
  }
}
