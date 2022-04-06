import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/firebase_data.dart';
import 'package:flutter_chodi_app/screens/impact/impact_screen.dart';
import 'package:flutter_chodi_app/services/firebase_authentication_service.dart';
import 'package:flutter_chodi_app/services/firebase_storage_service.dart';
import 'package:flutter_chodi_app/widget/organization_widget.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/main_view_model.dart';

FirebaseService fbservice = FirebaseService();
Storage storage = Storage();
late Future _dataRequiredForBuild;

class OrganizationScreen extends StatefulWidget {
  const OrganizationScreen({Key? key}) : super(key: key);
  @override
  State<OrganizationScreen> createState() => _OrganizationScreen();
}

Future<List<dynamic>> _fetchDataForBuild() async {
  List<dynamic> listURL = [];

  await fbservice.getUserSupportedOrganizationsData().then((res) async => {
        for (var i = 0; i < res.length; i++)
          {
            await storage.downloadURL(res[i]['assetURL']).then((res2) => {
                  listURL.add({
                    'organization': [res[i]["organizationName"], res2]
                  })
                  //"organization" : [World Concern, imageDownloadURL]
                })
          }
      });
  return listURL;
}

_createOrganizationWidget([List<dynamic>? data]) {
  var list = <Widget>[];

  if (data != null) {
    for (var i = 0; i < data.length; i++) {
      list.add(OrganizationWidget(
          img: data[i]['organization'][1], name: data[i]['organization'][0]));
    }
  }

  return list;
}

class _OrganizationScreen extends State<OrganizationScreen> {
  @override
  void initState() {
    super.initState();
    _dataRequiredForBuild = _fetchDataForBuild();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([_dataRequiredForBuild]),
        builder: ((context, AsyncSnapshot<dynamic> snapshot) {
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
                          .setWidget(const ImpactScreen());
                    },
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 10),
                      child: Text(
                        "Organization You Support",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                        children: _createOrganizationWidget(snapshot.data[0])),
                  ),
                ],
              ),
            );
          }
        }));
  }
}
