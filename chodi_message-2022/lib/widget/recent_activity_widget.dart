import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/activity.dart';

class RecentActivityWidget extends StatelessWidget {
  const RecentActivityWidget({Key? key, required this.activity})
      : super(key: key);
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
          child: Image.network(activity.img!,
              height: 36, width: 36, fit: BoxFit.cover),
          /*
          child: Image.asset(
            activity.img!,
            height: 36,
            width: 36,
            fit: BoxFit.fill,
          ),
          */
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(activity.name!))),
        Padding(
          padding: const EdgeInsets.only(right: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(activity.hours!,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFFFDB45C))),
              Text(activity.date!,
                  style:
                      // ignore: use_full_hex_values_for_flutter_colors
                      const TextStyle(fontSize: 12, color: Color(0xfff1eb893)))
            ],
          ),
        ),
        SvgPicture.asset(
          "assets/svg/arrow_right.svg",
          width: 15,
          height: 15,
        )
      ],
    );
  }
}
