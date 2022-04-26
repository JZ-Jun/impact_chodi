import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

enum Share {
  facebook,
  messenger, //not working?
  twitter,
  // ignore: constant_identifier_names
  share_instagram, //not working?
}

class ShareModal {
  File? file;
  ImagePicker picker = ImagePicker();
  bool videoEnable = false;

  Future shareModalSocialMedia(
      BuildContext context, String textToBeShared) async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Share",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 108, 108, 108),
                    thickness: 0.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
                    child: Row(
                      children: [
                        IconButton(
                          iconSize: 60,
                          onPressed: () =>
                              onButtonTap(Share.facebook, textToBeShared),
                          icon: const Icon(
                            Icons.facebook,
                            color: Color(0xff4267b2),
                          ),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          iconSize: 60,
                          onPressed: () =>
                              onButtonTap(Share.twitter, textToBeShared),
                          icon: const Icon(
                            FontAwesomeIcons.twitter,
                            color: Colors.blue,
                          ),
                        ),
                        /*
                        IconButton(
                          iconSize: 60,
                          onPressed: () => onButtonTap(
                              Share.share_instagram, textToBeShared),
                          icon: const Icon(
                            FontAwesomeIcons.instagramSquare,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          iconSize: 60,
                          onPressed: () =>
                              onButtonTap(Share.messenger, textToBeShared),
                          icon: const Icon(
                            FontAwesomeIcons.message,
                            color: Color.fromARGB(255, 32, 161, 21),
                          ),
                        ),
                        */
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> onButtonTap(Share share, String textToBeShared) async {
    String msg = textToBeShared;
    String url = '';

    String? response;
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    switch (share) {
      case Share.facebook:
        response = await flutterShareMe.shareToFacebook(url: url, msg: msg);
        break;
      case Share.messenger:
        response = await flutterShareMe.shareToMessenger(url: url, msg: msg);
        break;
      case Share.twitter:
        response = await flutterShareMe.shareToTwitter(url: url, msg: msg);
        break;

      case Share.share_instagram:
        response = await flutterShareMe.shareToInstagram(
            filePath: file!.path,
            fileType: videoEnable ? FileType.video : FileType.image);
        break;
    }
    debugPrint(response);
  }
}
