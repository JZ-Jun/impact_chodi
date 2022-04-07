import 'package:flutter/material.dart';

class StripGuide extends StatelessWidget {
  const StripGuide({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.23;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 12,
          width: width,
          decoration: BoxDecoration(
              color: index == 0 ? const Color(0xFF76D6E1) : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(6))),
        ),
        Container(
          height: 12,
          width: width,
          decoration: BoxDecoration(
              color: index == 1 ? const Color(0xFF76D6E1) : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(6))),
        ),
        Container(
          height: 12,
          decoration: BoxDecoration(
              color: index == 2 ? const Color(0xFF76D6E1) : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(6))),
          width: width,
        )
      ],
    );
  }
}
