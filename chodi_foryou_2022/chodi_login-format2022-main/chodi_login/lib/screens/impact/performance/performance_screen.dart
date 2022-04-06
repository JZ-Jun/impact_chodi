import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/configs/app_theme.dart';
import 'package:flutter_chodi_app/screens/impact/impact_screen.dart';
import 'package:flutter_chodi_app/services/firebase_authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../viewmodel/main_view_model.dart';
import 'line_chart.dart';

FirebaseService fbservice = FirebaseService();

//get data from all events
//access timestamp example: list[i]['date']
Future getChartValues() async {
  var list;
  await fbservice.getUserRecentHistoryData().then((res) => {
        list = res,
      });
  print(list);
  return list;
}

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({Key? key}) : super(key: key);

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  final Color _timeSelectColor = const Color(0xFF57CADB);
  final Color _timeUnSelectedColor = const Color(0xFFF8F8F6);
  late Color _weekBg, _monthBg, _yearBg;
  late Widget _timeWidget;

  DateTime currentDate = DateTime.now();
  var formattToYear = DateFormat('yyyy');
  var year;

  var month = 2;
  List<String> monthList = [];

  // List<Color> bgColorList = <Color>[];

  @override
  void initState() {
    super.initState();
    _weekBg = _timeSelectColor;
    _monthBg = _timeUnSelectedColor;
    _yearBg = _timeUnSelectedColor;
    _timeWidget = _getWeekWidget();
    _setupMonthList();

    year = int.parse(formattToYear.format(currentDate));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getChartValues(),
        builder: ((context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 16,
                  right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Image.asset(
                      "assets/images/back.png",
                      height: 40,
                      width: 40,
                      fit: BoxFit.fill,
                    ),
                    onTap: () {
                      Provider.of<MainScreenViewModel>(context, listen: false)
                          .setWidget(const ImpactScreen());
                    },
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      child: Text(
                        "Performance",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: const Color(0xFFF2F2F6),
                    margin: const EdgeInsets.only(bottom: 12),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 28,
                          decoration: BoxDecoration(
                              color: _weekBg,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: const Text(
                            "Week",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        onTap: () {
                          _updateSelectedTime(0);
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 28,
                          decoration: BoxDecoration(
                              color: _monthBg,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: const Text(
                            "Month",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        onTap: () {
                          _updateSelectedTime(1);
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 28,
                          decoration: BoxDecoration(
                              color: _yearBg,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: const Text(
                            "Year",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        onTap: () {
                          _updateSelectedTime(2);
                        },
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: const Color(0xFFF2F2F6),
                    margin: const EdgeInsets.only(top: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: _timeWidget,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: const Color(0xFFF2F2F6),
                    margin: const EdgeInsets.only(bottom: 12),
                  ),
                  const Expanded(child: LineChart())
                ],
              ),
            );
          }
        }));
  }

  void _updateSelectedTime(int index) {
    setState(() {
      if (index == 0) {
        _weekBg = _timeSelectColor;
        _monthBg = _timeUnSelectedColor;
        _yearBg = _timeUnSelectedColor;
        _timeWidget = _getWeekWidget();
      } else if (index == 1) {
        _weekBg = _timeUnSelectedColor;
        _monthBg = _timeSelectColor;
        _yearBg = _timeUnSelectedColor;
        _timeWidget = _getMonthWidget();
      } else {
        _weekBg = _timeUnSelectedColor;
        _monthBg = _timeUnSelectedColor;
        _yearBg = _timeSelectColor;
        _timeWidget = _getYearWidget();
      }
    });
  }

  Widget _getWeekWidget() {
    return const Padding(
      padding: EdgeInsets.only(top: 7, bottom: 7),
      child: Text(
        "This week",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _getMonthWidget() {
    return GestureDetector(
      child: Container(
        width: 160,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        decoration: const BoxDecoration(
            color: Color(0xFFF8F8F6),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            GestureDetector(
              child: const Text("<"),
              onTap: () {
                setState(() {
                  if (month > 0) {
                    month = month - 1;
                    _timeWidget = _getMonthWidget();
                  }
                });
              },
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text("${monthList[month]} 2022")),
            GestureDetector(
              child: const Text(">"),
              onTap: () {
                setState(() {
                  if (month < 12) {
                    month = month + 1;
                    _timeWidget = _getMonthWidget();
                  }
                });
              },
            ),
          ],
        ),
      ),
      onTap: () {
        _selectMonthDialog();
      },
    );
  }

  Widget _getYearWidget() {
    return GestureDetector(
      child: Container(
        width: 160,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        decoration: const BoxDecoration(
            color: Color(0xFFF8F8F6),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  year = year - 1;
                  _timeWidget = _getYearWidget();
                });
              },
              child: const Text("<"),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text("Year ${year}")),
            GestureDetector(
              onTap: () {
                setState(() {
                  year = year + 1;
                  _timeWidget = _getYearWidget();
                });
              },
              child: const Text(">"),
            ),
          ],
        ),
      ),
      onTap: () {
        _selectYearDialog();
      },
    );
  }

  Future _selectYearDialog() async {
    List<SimpleDialogOption> list = <SimpleDialogOption>[];

    for (int i = year; i > 2015; i--) {
      list.add(SimpleDialogOption(
        child: Text(i.toString()),
        onPressed: () {
          setState(() {
            year = i;
            _timeWidget = _getYearWidget();
          });
          Navigator.pop(context);
        },
      ));
    }
    await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(children: list);
        });
  }

  Future _selectMonthDialog() async {
    List<SimpleDialogOption> list = <SimpleDialogOption>[];
    for (int i = 0; i < 12; i++) {
      list.add(SimpleDialogOption(
        child: Text(monthList[i]),
        onPressed: () {
          setState(() {
            month = i;
            _timeWidget = _getMonthWidget();
          });
          Navigator.pop(context);
        },
      ));
    }
    await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: list,
          );
        });
  }

  _setupMonthList() {
    monthList.add("Jan");
    monthList.add("Feb");
    monthList.add("Mar");
    monthList.add("Apr");
    monthList.add("May");
    monthList.add("Jun");
    monthList.add("Jul");
    monthList.add("Aug");
    monthList.add("Sept");
    monthList.add("Oct");
    monthList.add("Nov");
    monthList.add("Dec");
  }
}
