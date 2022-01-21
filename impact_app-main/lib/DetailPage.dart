import 'package:flutter/material.dart';
import 'VolunteeringActivity.dart';
import 'DonationActivity.dart';
import 'activity.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget{
  const DetailPage({Key? key}) : super(key: key);
  static const routeName = '/details';
  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as Activity;
    final DateFormat formatter = DateFormat('MM-dd-yyyy');
    var summary = args.summary;
    return MaterialApp(
      title:"detail",
      home: Scaffold(
      appBar: AppBar(
        title: Text("detail",
        textAlign: TextAlign.center,),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          //onPressed:() => Navigator.pop(context, false),
          onPressed:() => Navigator.pop(context),
        )
      ),
      body: Column(
        children:  <Widget>[
          
          Text(formatter.format(args.date)),
          Text(args.summary),
        ],
      ),
    ),
    );
  }

}

