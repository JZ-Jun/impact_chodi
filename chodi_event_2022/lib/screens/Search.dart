import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_chodi_app/screens/QueryTest.dart';
import 'package:flutter_chodi_app/models/event.dart';

class EventIdNumberSearcher extends StatefulWidget {
  @override
  _EventIdNumberSearchState createState() => _EventIdNumberSearchState() ;
}

class _EventIdNumberSearchState extends State<EventIdNumberSearcher> {
  String ein = "" ;
  late Stream dataList = FirebaseFirestore.instance
      .collection("events")
      .orderBy("eventName", descending: false)
      .snapshots();

  List<Event> eventList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                ein = val ;
              });
            },
            ),
          ),
        ),
      body: StreamBuilder(
        stream: dataList,
        builder: (context, AsyncSnapshot snapshot) {
          for (var i in snapshot.data!.docs) {
            eventList.add(Event.fromFirestore(i));
          }
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: Text(eventList.toString()))
              : ListView.builder(
                itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  return Container (
                    padding: EdgeInsets.only(top: 16),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(data['eventName'],
                            style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                          leading: CircleAvatar(
                            //child: Image.network(
                             // data['imageUrl'],
                             // width: 100,
                              //height: 50,
                             //fit: BoxFit.contain,
                            //),
                            radius: 40,
                            backgroundColor: Colors.lightBlue,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        )
                      ],
                    ),
                  );
            }
          );
        },
      ),
    );
    }
  }




/*
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SearchDelegate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: "SearchDelegate"),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              "10",
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        //onPressed: () async {
          //final result = await showSearch<String>(
            //context: context,
            //delegate: QueryTester(),
          //);

          //print(result);
        //},
        onPressed: (){
          showSearch(
              context: context,
              delegate: QueryTester()
          );
        },
      ),
    );
  }
}*/
