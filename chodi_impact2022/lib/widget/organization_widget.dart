import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/configs/app_theme.dart';

class OrganizationWidget extends StatelessWidget {
  const OrganizationWidget({Key? key, required this.img, required this.name})
      : super(key: key);
  final String img;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 17, right: 10),
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.38),
      decoration: const BoxDecoration(
          color: Color(0xFFFF8F8F6),
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              img,
              fit: BoxFit.fill,
              width: 40,
              height: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              name,
              style: const TextStyle(color: AppTheme.fontColor),
            ),
          )
        ],
      ),
    );
  }
}
