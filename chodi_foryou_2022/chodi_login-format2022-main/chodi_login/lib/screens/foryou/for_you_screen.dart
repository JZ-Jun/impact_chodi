import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/foryou/search_page.dart';
import 'package:flutter_chodi_app/widget/SwiperPagination.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import 'community_page.dart';
import 'detail_page.dart';
import 'interest_page.dart';

class ForYouScreen extends StatefulWidget {
  const ForYouScreen({Key? key}) : super(key: key);

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  List<String> bannerList = [
    'assets/images/for_you.png',
    'assets/images/for_you.png',
    'assets/images/for_you.png'
  ];
  List<String> communityList = [
    'Save the Children',
    'unicef',
    'animal save',
    'example'
  ];
  List<String> interestList = [
    'Doctors without Borders',
    'Doctors without Borders',
    'Doctors without Borders',
    'example'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('C', style: TextStyle(fontSize: 25, color: Colors.yellow)),
              Text('H', style: TextStyle(fontSize: 25, color: Colors.orange)),
              Text('O', style: TextStyle(fontSize: 25, color: Colors.red)),
              Text('D', style: TextStyle(fontSize: 25, color: Colors.blue)),
              Text('I', style: TextStyle(fontSize: 25, color: Colors.green))
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.grey.shade400,
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return search_page();
                  }));
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.search),
                ))
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Featured',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Container(
                color: Colors.transparent,
                child: SizedBox.fromSize(
                  size: Size.fromHeight(170),
                  child: new Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Image.asset(
                          bannerList[index],
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                    //自定义指示器
                    pagination: SwiperPagination(
                        margin: new EdgeInsets.only(bottom: 0),
                        builder: CustomRectSwiperPaginationBuilder(
                            color: Colors.grey.shade300,
                            activeColor: Colors.grey,
                            sizeW: 15,
                            sizeH: 15,
                            activeSizeW: 15,
                            activeSizeH: 15,
                            space: 5)),
                    loop: true,
                    autoplayDelay: 5000,
                    itemCount: bannerList.length,
                    control: null,
                    duration: 1000,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1,
                    autoplay: false,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Text('Explore Your Community',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                  'Support and expower nonprofits around your local area. Be the change in your community!'),
              Container(
                height: 150,
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return buildItem(index, communityList[index]);
                    },
                    itemCount: communityList.length,
                    scrollDirection: Axis.horizontal),
              ),
              SizedBox(height: 5),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return community_page();
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('More', style: TextStyle(color: Colors.blue)),
                      SizedBox(width: 5),
                      Icon(Icons.chevron_right, color: Colors.blue)
                    ],
                  )),
              SizedBox(height: 5),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Text('Based on your Interests',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              Container(
                height: 150,
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return buildItem(index, interestList[index]);
                    },
                    itemCount: interestList.length,
                    scrollDirection: Axis.horizontal),
              ),
              SizedBox(height: 5),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return interest_page();
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('More', style: TextStyle(color: Colors.blue)),
                      SizedBox(width: 5),
                      Icon(Icons.chevron_right, color: Colors.blue)
                    ],
                  )),
              SizedBox(height: 10),
            ],
          )),
        ));
  }

  buildItem(int index, String txt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return detail_page(txt);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 110,
                child: Image.asset(
                  'assets/images/for_you.png',
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                  child: Container(
                width: 120,
                alignment: Alignment.centerLeft,
                color: Colors.grey.shade200,
                padding: EdgeInsets.only(left: 5),
                child: Text('$txt', style: TextStyle(fontSize: 10)),
              ))
            ],
          ),
        ));
  }
}
