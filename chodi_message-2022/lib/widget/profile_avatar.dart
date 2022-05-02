import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  String assetURL;
  List<Widget> organizationAvatars = [];

  ProfileAvatar({Key? key, required this.assetURL}) : super(key: key);

  //Return a dynamic Row
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //do something
      },
      //Displays image retrieved from Firebase
      child: CircleAvatar(
        child:
            Image.asset(assetURL), //Image.network(assetURL, fit: BoxFit.cover),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
