import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';

class community_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return community_page_state();
  }
}

class community_page_state extends State<community_page> {
  List<String> communityList = [
    'Save the Children',
    'unicef',
    'animal save',
    'example'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.grey.shade400,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //横轴元素个数
                crossAxisCount: 2,
                //纵轴间距
                mainAxisSpacing: 10.0,
                //横轴间距
                crossAxisSpacing: 10.0,
                //子组件宽高长度比例
                childAspectRatio: 1.0),
            itemBuilder: (context, index) {
              return buildItem(index);
            },
            itemCount: communityList.length),
      ),
    );
  }

  buildItem(int index) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return detail_page(communityList[index]);
          }));
        },
        child: Container(
          margin: EdgeInsets.only(left: 5, top: 10, right: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.grey),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 2.0,
                    spreadRadius: 1.0)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 140,
                child: Image.asset(
                  'assets/images/for_you.png',
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                color: Colors.grey.shade200,
                padding: EdgeInsets.only(left: 5),
                child: Text('${communityList[index]}',
                    style: TextStyle(fontSize: 10)),
              ))
            ],
          ),
        ));
  }
}
