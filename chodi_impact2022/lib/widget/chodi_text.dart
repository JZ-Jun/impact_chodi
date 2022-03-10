import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/configs/app_theme.dart';

class ChodiText extends StatelessWidget {
  const ChodiText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "C",
              style: TextStyle(
                  fontSize: 47,
                  color: Color(0xFFFFFF00),
                  decoration: TextDecoration.none),
            ),
            Text(
              "H",
              style: TextStyle(
                  fontSize: 47,
                  color: Color(0xFFFF9900),
                  decoration: TextDecoration.none),
            ),
            Text(
              "O",
              style: TextStyle(
                  fontSize: 47,
                  color: Color(0xFFE2474A),
                  decoration: TextDecoration.none),
            ),
            Text(
              "D",
              style: TextStyle(
                  fontSize: 47,
                  color: Color(0xFF4061FF),
                  decoration: TextDecoration.none),
            ),
            Text(
              "I",
              style: TextStyle(
                  fontSize: 47,
                  color: Color(0xFF4AC913),
                  decoration: TextDecoration.none),
            )
          ],
        ),
        const Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text(
              "Create Hope & Opportunity",
              style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.fontColor,
                  decoration: TextDecoration.none),
            )),
        const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Text(
            "By Direct impact",
            style: TextStyle(
                fontSize: 14,
                color: AppTheme.fontColor,
                decoration: TextDecoration.none),
          ),
        )
      ],
    );
  }
}
