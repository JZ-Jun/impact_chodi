import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class LineChart extends StatefulWidget {
  final int selectorType;
  final int month =
      int.parse(DateFormat.M().format(DateTime.now())) - 1; //default Jan
  final int year = int.parse(DateFormat('yyyy').format(DateTime.now()));
  LineChart({Key? key, required this.selectorType, month, year})
      : super(key: key);
  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  late Stream chartDataList;
  List<ChartData> eventData = [];
  List<ChartData> donatedData = [];
  int numberOfEvents = 0;
  double totalHours = 0;
  double totalDonations = 0;
  double maxEventHours = 0;
  double maxDonations = 0;
  String userUID = "SM5W6pnRdqMgQW1znKusvHXpjHT2";
  //String userUID = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();

    chartDataList = FirebaseFirestore.instance
        .collection("EndUsers/" + userUID + "/History")
        .snapshots();
  }

  _resetChartData() {
    eventData.clear();
    donatedData.clear();
    numberOfEvents = 0;
    totalHours = 0;
    totalDonations = 0;
    maxEventHours = 0;
    maxDonations = 0;
  }

  @override
  Widget build(BuildContext context) {
    //print selectorType
    //log(widget.selectorType.toString());
    //log(widget.month.toString());
    //log(widget.year.toString());

    _resetChartData();

    if (widget.selectorType == 0) {
      //week
      log('day');

      chartDataList = FirebaseFirestore.instance
          .collection("EndUsers/" + userUID + "/History")
          .where("date", isLessThanOrEqualTo: DateTime.now())
          .where("date",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(const Duration(days: 7)))
          .snapshots();
    } else if (widget.selectorType == 1) {
      //month
      List<int> months = [
        DateTime.january,
        DateTime.february,
        DateTime.march,
        DateTime.april,
        DateTime.june,
        DateTime.july,
        DateTime.august,
        DateTime.september,
        DateTime.october,
        DateTime.november,
        DateTime.december,
      ];

      int daysInAMonth = DateTime(widget.year, months[widget.month] + 1, 0).day;

      chartDataList = FirebaseFirestore.instance
          .collection("EndUsers/" + userUID + "/History")
          .where("date", isLessThanOrEqualTo: DateTime.now())
          .where("date",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(Duration(days: daysInAMonth)))
          .snapshots();
    } else {
      //year
      int daysInAYear = 365;
      if (widget.year % 4 == 0) {
        daysInAYear = 366;
      }
      chartDataList = FirebaseFirestore.instance
          .collection("EndUsers/" + userUID + "/History")
          .where("date", isLessThanOrEqualTo: DateTime.now())
          .where("date",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(Duration(days: daysInAYear)))
          .snapshots();
    }

    return StreamBuilder(
        stream: chartDataList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Container();
          } else {
            var date = DateFormat('M-d').format(DateTime.now());
            for (var i in snapshot.data!.docs) {
              if (i["IsEvent"] == true && i["showedUp"] == true) {
                if (i["hours"].toDouble() > maxEventHours) {
                  maxEventHours = i["hours"].toDouble();
                  numberOfEvents++;
                }
                totalHours += i["hours"].toDouble();
                eventData.add(ChartData(date, i["hours"].toDouble()));
              } else {
                if (i["donationAmount"].toDouble() > maxDonations) {
                  maxDonations = i["donationAmount"].toDouble();
                }
                totalDonations += i["donationAmount"].toDouble();
                donatedData
                    .add(ChartData(date, i["donationAmount"].toDouble()));
              }
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Donated: \$$totalDonations"),
              Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF4A164),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      const Text("\$")
                    ],
                  )),
              Expanded(
                  child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                    majorTickLines: const MajorTickLines(size: 0),
                    axisLine: const AxisLine(width: 0)),
                primaryYAxis: NumericAxis(
                    maximum: maxDonations > 1
                        ? maxDonations + (maxDonations * 0.1)
                        : 5, //Max y-value
                    minimum: 0,
                    interval: maxDonations > 1
                        ? (maxDonations / 5).round().toDouble()
                        : 5,
                    isVisible: true,
                    labelFormat: '{value}',
                    majorGridLines: const MajorGridLines(width: 0)),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <StackedLineSeries<ChartData, String>>[
                  StackedLineSeries<ChartData, String>(
                      animationDuration: 3000,
                      markerSettings: const MarkerSettings(isVisible: true),
                      name: '\$',
                      // Bind data source
                      dataSource: donatedData,
                      width: 2.5,
                      color: const Color(0xFFF4A164),
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y)
                ],
              )),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Volunteered: $totalHours hours")),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Event: $numberOfEvents")),
              Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF4A164),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      const Text("Hours")
                    ],
                  )),
              Expanded(
                  child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                    majorTickLines: const MajorTickLines(size: 0),
                    axisLine: const AxisLine(width: 0)),
                primaryYAxis: NumericAxis(
                    maximum: maxEventHours > 1
                        ? maxEventHours + (maxEventHours * 0.1)
                        : 5, //max Y value
                    minimum: 0,
                    interval: maxEventHours > 1
                        ? (maxEventHours / 5).round().toDouble()
                        : 5,
                    labelFormat: '{value}',
                    isVisible: true,
                    axisLine: const AxisLine(width: 0),
                    majorGridLines: const MajorGridLines(width: 0)),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <StackedLineSeries<ChartData, String>>[
                  StackedLineSeries<ChartData, String>(
                      markerSettings: const MarkerSettings(isVisible: true),
                      animationDuration: 3000,
                      name: 'hours',
                      // Bind data source
                      dataSource: eventData,
                      width: 2.5,
                      color: const Color(0xFFF4A164),
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y)
                ],
              )),
            ],
          );
        });
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
