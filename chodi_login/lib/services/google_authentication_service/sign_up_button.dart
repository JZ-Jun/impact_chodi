import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'google_authentication.dart';
import 'dart:developer'; //for printing

/*Text Link for signing up for Chodi*/

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    //font type not specified yet
    TextStyle defaultTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 12,
    );

    TextStyle googleLinkTextStyle = TextStyle(
      color: Colors.blue[800],
      fontStyle: FontStyle.italic,
      fontSize: 12,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 20), //margin padding
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RichText(
          text: TextSpan(
            style: defaultTextStyle,
            children: <TextSpan>[
              const TextSpan(text: 'New to CHoDi? '),
              TextSpan(
                  text: 'Sign Up',
                  style: googleLinkTextStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //Sign in implementation goes here
                      final provider = Provider.of<GoogleAuthentication>(
                          context,
                          listen: false);
                      provider.googleLogin(); //enable login
                      log('Click!');
                    }),
            ],
          ),
        ),
      ),
    );
  }
}
