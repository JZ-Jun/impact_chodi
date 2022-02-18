// ignore_for_file: dead_code

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'nonprofit.dart';
import 'VolunteeringActivity.dart';
import 'DonationActivity.dart';
import 'activity.dart';
import 'DetailPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blue[600],
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline2: TextStyle(
              fontSize: 32.0, fontWeight: FontWeight.w400, color: Colors.white),
          headline3: TextStyle(
              fontSize: 28.0, fontWeight: FontWeight.w400, color: Colors.white),
          headline4: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.w400, color: Colors.white),
          headline6: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.w200, color: Colors.white),
          bodyText1: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w200,
          ),
        ),
        fontFamily: 'Consolas',
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
    '''return MaterialApp(
      routes: {
        DetailPage.routeName: (context) => const DetailPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );''';
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Nonprofits> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        animationDuration: 1000,
        duration: 5,
        decimalPlaces: 1,
        textStyle: TextStyle(color: Colors.green[500]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    const List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 0: Home',
        style: optionStyle,
      ),
      Text(
        'Index 1: Business',
        style: optionStyle,
      ),
      Text(
        'Index 2: School',
        style: optionStyle,
      )
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    List<Activity> activities = [
      VolunteeringActivity('Autism Speak', DateTime.utc(2021, 11, 15),
          Icon(Icons.extension_rounded), 3),
      DonationActivity('Action in Africa', DateTime.utc(2021, 10, 25),
          Icon(Icons.support), 20),
      VolunteeringActivity(
          'Lifewater', DateTime.utc(2021, 9, 15), Icon(Icons.water), 5),
      DonationActivity(
          'World Concern', DateTime.utc(2021, 9, 21), Icon(Icons.public), 50)
    ];

    return Container(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
            SizedBox(height: 40),
            Container(
              child: Text("Hi Daniel, here's your impact summary",
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            SizedBox(height: 10),
            Container(
                height: 400,
                width: 500,
                child: SfCircularChart(
                  margin: EdgeInsets.all(0),
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                        widget: Container(
                            child: const Text(
                                "\n"
                                "\n"
                                "\n"
                                "\n"
                                "\n"
                                "\n"
                                "\n"
                                "\n"
                                "\n"
                                "\n"
                                "\n"
                                "\n"
                                "\n"
                                "dollars or hours",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10))),
                        radius: '90%',
                        verticalAlignment: ChartAlignment.center)
                    //horizontalAlignment: ChartAlignment.far)
                  ],
                  series: <CircularSeries>[
                    DoughnutSeries<Nonprofits, String>(
                        dataSource: getChartData(),
                        pointColorMapper: (Nonprofits data, _) => data.color,
                        xValueMapper: (Nonprofits data, _) => data.org,
                        yValueMapper: (Nonprofits data, _) => data.impact,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        explode: true,
                        explodeAll: true,
                        explodeOffset: "0%")
                    //enableTooltip: true)
                    //maximumValue: 40000)
                  ],
                  legend: Legend(
                      orientation: LegendItemOrientation.horizontal,
                      padding: 5,
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap,
                      position: LegendPosition.bottom,
                      textStyle: TextStyle(fontSize: 16)),
                  tooltipBehavior: _tooltipBehavior,
                )),
            SizedBox(height: 20),
            Container(
              child: Text("Milestone Breakdown",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 20),
            Container(
                height: 250,
                width: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.orangeAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.baseline,
                    //textBaseline: TextBaseline.alphabetic,
                    children: [
                      SizedBox(height: 40),
                      Row(children: [
                        SizedBox(width: 25),
                        Text(
                          'Volunteer',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 75),
                        Text(
                          'Remaining',
                          style: TextStyle(
                              color: Colors.brown[900],
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(width: 40),
                          Text('40.0',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: 15),
                          Text('hours',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(width: 90),
                          Text('20.0',
                              style: TextStyle(
                                  color: Colors.brown[900],
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Stack(fit: StackFit.loose, children: [
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 370,
                          child: Center(
                            child: SfLinearGauge(
                              axisTrackStyle: LinearAxisTrackStyle(
                                thickness: 25,
                                edgeStyle: LinearEdgeStyle.bothCurve,
                                color: Colors.brown[900],
                              ),
                              showLabels: false,
                              showTicks: false,
                              barPointers: [
                                LinearBarPointer(
                                    thickness: 25,
                                    value: 80,
                                    edgeStyle: LinearEdgeStyle.bothCurve,
                                    //Change the color
                                    color: Colors.white)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 200),
                        Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 200,
                            child: Text('2 weeks left to complete!',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500))),
                        Column(children: [
                          Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              width: 350,
                              child: Text('80%',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))),
                        ]),
                      ]),
                      Stack(
                        children: [
                          SizedBox(width: 50),
                          Container(
                            alignment: Alignment.center,
                            child: Text('monthly goal: 60 dollars',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                          )
                        ],
                      )
                    ],
                  ),
                )),
            SizedBox(height: 20),
            Container(
              child: Text("Recent History",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                      fontWeight: FontWeight.w700)),
            ),
            //SizedBox(height: 10),
            Container(
                height: 400,
                padding: const EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white70,
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          List.generate(activities.length * 2 - 1, (index) {
                        if (index.isOdd) {
                          return const Divider();
                        }
                        if (index == 0) {
                          return _buildRow(activities[index]);
                        }
                        int i = (index - (index ~/ 2)) as int;
                        return _buildRow(activities[i]);
                      }),
                    ))),
            //SizedBox(height: 5),
            Container(
              child: Text("Badges",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 10),
            Container(
              height: 125,
              padding: EdgeInsets.all(15.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 110,
                    color: Colors.grey,
                    child: const Center(
                        child: Text(
                      'Badge 1',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  SizedBox(width: 25),
                  Container(
                    width: 110,
                    color: Colors.grey,
                    child: const Center(
                        child: Text(
                      'Badge 2',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  SizedBox(width: 25),
                  Container(
                    width: 110,
                    color: Colors.grey,
                    child: const Center(
                        child: Text(
                      'Badge 3',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                ],
              ),
            ),
          ])),
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.equalizer), label: 'Information'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    ));
  }

  Widget _buildRow(Activity a) {
    Color fontcolor = Colors.green;
    Activity? arg;
    if (a is VolunteeringActivity) {
      fontcolor = Colors.orange;
      arg = VolunteeringActivity(
        a.org,
        a.date,
        a.icon,
        (a as VolunteeringActivity).hours,
      );
    } else if (a is DonationActivity) {
      arg = DonationActivity(
          a.org, a.date, a.icon, (a as DonationActivity).dollars);
    }

    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailPage.routeName,
          arguments: arg,
        );
      },
      title: Text(a.org, style: TextStyle(fontWeight: FontWeight.w500)),
      leading: a.icon,
      subtitle: Text(a.org),
      trailing: Text(
          (() {
            if (a is DonationActivity) {
              return (a as DonationActivity).dollars.toStringAsPrecision(2) +
                  ' dollars';
            }
            return (a as VolunteeringActivity).hours.toString() + ' hours';
          }()),
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 20, color: fontcolor)),
    );
  }

  List<Nonprofits> getChartData() {
    final List<Nonprofits> chartData = [
      Nonprofits('Education', 50, Colors.deepPurple),
      Nonprofits('Cultural', 25, Colors.red),
      Nonprofits('Health', 15, Colors.teal),
      Nonprofits('Environment', 5, Colors.yellowAccent),
    ];
    return chartData;
  }
}
