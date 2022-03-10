import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/activity.dart';
import 'package:flutter_chodi_app/screens/impact/organization_screen.dart';
import 'package:flutter_chodi_app/screens/impact/performance/performance_screen.dart';
import 'package:flutter_chodi_app/screens/impact/recent_activity_screen.dart';
import 'package:flutter_chodi_app/viewmodel/main_view_model.dart';
import 'package:flutter_chodi_app/widget/recent_activity_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../widget/clock/analog_clock.dart';

class ImpactScreen extends StatefulWidget {
  const ImpactScreen({Key? key}) : super(key: key);

  @override
  State<ImpactScreen> createState() => _ImpactScreenState();
}

class _ImpactScreenState extends State<ImpactScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1300),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() => {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10, left: 16, right: 16),
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "Hi there",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              AnalogClock(
                decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.black),
                    color: Colors.transparent,
                    shape: BoxShape.circle),
                width: 100.0,
                height: 100.0,
                isLive: true,
                hourHandColor: Colors.black,
                minuteHandColor: Colors.black,
                showSecondHand: true,
                numberColor: Colors.black87,
                showNumbers: true,
                showAllNumbers: true,
                textScaleFactor: 1.4,
                showTicks: true,
                showDigitalClock: false,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 3),
                child: Text(
                  "Hours Volunteered",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  (68713 * animation.value).toInt().toString(),
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  "Donated",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/dollar.png",
                      width: 23,
                      height: 23,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 5, right: 23),
                        child: Text(
                          "${(56489 * animation.value).toInt().toString()}",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 26),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text("Organizations You Support"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/img.png',
                        height: 45,
                        width: 45,
                        fit: BoxFit.fill,
                      ),
                    ),
                    ClipOval(
                      child: Image.asset(
                        'assets/images/img.png',
                        height: 45,
                        width: 45,
                        fit: BoxFit.fill,
                      ),
                    ),
                    ClipOval(
                      child: Image.asset(
                        'assets/images/img.png',
                        height: 45,
                        width: 45,
                        fit: BoxFit.fill,
                      ),
                    ),
                    ClipOval(
                      child: Image.asset(
                        'assets/images/img.png',
                        height: 45,
                        width: 45,
                        fit: BoxFit.fill,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("object");
                        Provider.of<MainScreenViewModel>(this.context,
                                listen: false)
                            .setWidget(const OrganizationScreen());
                      },
                      child: SvgPicture.asset(
                        "assets/svg/arrow_right.svg",
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22, bottom: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text("Recent Activity"),
                ),
              ),
              RecentActivityWidget(
                  activity: Activity("assets/images/img_1.png", "Autism Speaks",
                      "3 hours", "Oct 25, 2021")),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RecentActivityWidget(
                    activity: Activity("assets/images/img_2.png",
                        "World Concern", "3 hours", "Oct 25, 2021")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<MainScreenViewModel>(this.context,
                            listen: false)
                        .setWidget(const RecentActivityScreen());
                  },
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Text("More",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF0000FF))),
                      ),
                      SvgPicture.asset(
                        "assets/svg/arrow_right.svg",
                        width: 13,
                        height: 13,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    const Text(
                      "What you’ve done",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                        onTap: () {
                          Provider.of<MainScreenViewModel>(this.context,
                                  listen: false)
                              .setWidget(const PerformanceScreen());
                        },
                        child: const Text(
                          "See Performance",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFF0000FF)),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    const Text("Donated"),
                    const Expanded(child: SizedBox()),
                    Text(
                      "\$${(880 * animation.value).toInt().toString()}",
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 26),
                child: Row(
                  children: const [
                    Text("Participated Event"),
                    Expanded(child: SizedBox()),
                    Text(
                      "9",
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
