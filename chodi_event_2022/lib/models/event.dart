import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chodi_app/models/user.dart';

class Event {
  //eventCode on the DB
  String eventID;
  String orgName ;
  String ein;
  //title on the DB
  String name;


  //all deprecated? left in for any legacy code for the time being
  int zip;
  String city;
  String state;
  String country;
  String address;

  //Geoposition location
  //commented out until we can hook up dart html. Not necessary for the moment.
  String locationDescription ;
  String locationHelp ;

  Map <String,dynamic> attendees ;

  String imageURL;
  String description;
  String eventType ;

  Timestamp startTime;
  Timestamp endTime;

  //String? notes;
  //int availableSpace;
  int totalSpace;
  //Map<dynamic, dynamic> volunteers;

  Event({required this.eventID,
    required this.ein,
    required this.orgName,
    required this.name,


    required this.zip,
    required this.city,
    required this.state,
    required this.country,
    required this.address,

    required this.locationDescription,
    required this.locationHelp,

    required this.attendees,

    required this.imageURL,
    required this.description,
    required this.eventType,


    required this.startTime,
    required this.endTime,
    //this.notes,
    //required this.availableSpace,
    required this.totalSpace,
    //required this.volunteers}
  });

  int returnAvailableSpace() {
    return totalSpace - attendees.length ;
  }

  factory Event.fromFirestore(QueryDocumentSnapshot fbData) {
    Map data = fbData.data() as Map;

    //print(data) ;

    return Event(
        eventID: data['eventCode'],
        ein: data['EIN'] ?? '',
        name: data['title'] ?? '',
        orgName: data['OrgName'] ?? '',
        zip: data['Zip'] ?? 0,
        city: data['City'] ?? '',
        state: data['State'] ?? '',
        country: data['Country'] ?? '',
        address: data['Address'] ?? '',
        locationDescription: data['locationDescription'] ?? '',
        locationHelp: data['locationHelp'] ?? '',
        attendees: data['attendees'] ?? '',
        imageURL: data['imageURL'] ?? '',
        description: data['description'] ?? '',
        eventType: data['eventType'] ?? '',
        startTime: data['startTime'],
        endTime: data['endTime'],
    //    notes: data['Notes'] ?? '',
        //availableSpace: data['totalSpaceTaken'] ?? 0,
        totalSpace: data['totalSpace'] ?? 0,
        //volunteers: data['Volunteers'] ?? {}
        );
  }
}
