import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_chodi_app/services/firebase_authentication_service.dart';
import 'package:provider/provider.dart';
import 'google_authentication.dart';
import '../firebase_authentication_service.dart';
//import 'package:flutter_chodi_app/services/firebase_service.dart';

//Create a text link to log out of Chodi*/

// ignore: camel_case_types
class logOutWidget extends StatefulWidget {
  const logOutWidget({Key? key}) : super(key: key);

  @override
  _logOutWidgetState createState() => _logOutWidgetState();
}

// ignore: camel_case_types
class _logOutWidgetState extends State<logOutWidget> {
  FirebaseService fbservice = FirebaseService();

  @override
  Widget build(BuildContext context) {
    TextStyle googleLinkTextStyle = TextStyle(
      color: Colors.blue[800],
      fontStyle: FontStyle.normal,
      fontSize: 12,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 20), //margin padding
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RichText(
          text: TextSpan(
              text: 'Hours donated - Log Out: Testing Only',
              style: googleLinkTextStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  //if google user
                  final provider1 =
                      Provider.of<GoogleAuthentication>(context, listen: false);
                  provider1.googleLogOut();

                  //if regular user
                  final provider2 =
                      Provider.of<FirebaseService>(context, listen: false);
                  provider2.userLogOut(context);
                }),
        ),
      ),
    );
  }
}
