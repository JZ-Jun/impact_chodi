import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chodi_app/models/user.dart';

class Event {
  //eventCode on the DB
  String eventID;
  String orgName;
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
  String locationDescription;
  String locationHelp;

  Map<String, dynamic> attendees;

  //List<dynamic> attendees;

  String imageURL;
  String description;
  String eventType;

  Timestamp startTime;
  Timestamp endTime;

  //String? notes;
  //int availableSpace;
  int totalSpace;
  //Map<dynamic, dynamic> volunteers;

  Event({
    required this.eventID,
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
    return totalSpace - attendees.length;
  }

  factory Event.fromFirestore(DocumentSnapshot fbData) {
    Map data = fbData.data() as Map;

    //print(data) ;
    /*
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
      attendees: data['attendees'] ?? {},
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
    */
    String coordinates = "[34.03721° N, 118.44283° W]";
    String firstCoordinate = coordinates.split("°")[0].substring(1);
    String secondCoordinate = coordinates.split("°")[1].substring(4);
    return Event(
      eventID: "61-1405123",
      ein: "61-1405123",
      name: "Adopting/Fostering",
      orgName: "All Animal Rescue & Friends",
      zip: 95046,
      city: "San Martin",
      state: "CA",
      country: "USA",
      address: "PO Box 941",
      locationDescription: "San Martin, CA",
      locationHelp: '${firstCoordinate},${secondCoordinate}',
      attendees: {},
      imageURL: data['imageURL'] ?? '',
      // imageURL: "gs://chodi-663f2.appspot.com/nonprofitlogos/81-2661626.jpg",
      description: "We are a 501(c)3 non-profit all volunteer rescue organization focused on physically rescuing and reuniting lost/found animals within our community.  We provide medical assistance and care to the injured, abused, neglected, abandoned and underaged animals.  We also rescue at-risk animals from local shelters. For the animals that come into our rescue, they are placed in safe, nurturing foster homes to prepare them for adoption.  We are dedicated to match each and every animal with the very best forever home.",
      eventType: "Adopting",
      startTime: Timestamp.fromDate(DateTime.now()),
      endTime: Timestamp.fromDate(DateTime.now()),
      //    notes: data['Notes'] ?? '',
      //availableSpace: data['totalSpaceTaken'] ?? 0,
      totalSpace: 3,
      //volunteers: data['Volunteers'] ?? {}
    );
  }
}
