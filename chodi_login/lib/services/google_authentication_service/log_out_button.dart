import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'google_authentication.dart';

//Create a text link to log out of Chodi*/

class logOutWidget extends StatefulWidget {
  const logOutWidget({Key? key}) : super(key: key);

  @override
  _logOutWidgetState createState() => _logOutWidgetState();
}

class _logOutWidgetState extends State<logOutWidget> {
  @override
  Widget build(BuildContext context) {
    TextStyle googleLinkTextStyle = TextStyle(
      color: Colors.blue[800],
      fontStyle: FontStyle.normal,
      fontSize: 12,
    );

    return Container(
      margin: EdgeInsets.only(bottom: 20), //margin padding
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RichText(
          text: TextSpan(
              text: 'Log Out',
              style: googleLinkTextStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  final provider =
                      Provider.of<GoogleAuthentication>(context, listen: false);
                  provider.googleLogOut();
                }),
        ),
      ),
    );
  }
}
