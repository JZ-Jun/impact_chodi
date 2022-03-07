import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/impact/impact_screen.dart';
import 'package:flutter_chodi_app/widget/organization_widget.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/main_view_model.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];
    list.add(const OrganizationWidget(
      img: "assets/images/img_1.png",
      name: "Autism Speaks",
    ));
    list.add(const OrganizationWidget(
      img: "assets/images/img_2.png",
      name: "World Concern",
    ));
    list.add(const OrganizationWidget(
      img: "assets/images/img_3.png",
      name: "Autism Speaks",
    ));
    list.add(const OrganizationWidget(
      img: "assets/images/img_4.png",
      name: "LifeWater",
    ));
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
              padding: EdgeInsets.only(top: 16, bottom: 10),
              child: Text(
                "Organization You Support",
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
                        child: list[index],
                      );
                    },
                    itemCount: list.length,
                  )))
        ],
      ),
    );
  }
}
