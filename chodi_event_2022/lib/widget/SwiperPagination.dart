import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class CustomRectSwiperPaginationBuilder extends SwiperPlugin {
  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final Color? activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color? color;

  // ///Size of the rect when activate
  // final Size activeSize;

  // ///Size of the rect
  // final Size size;

  final double? sizeW;

  final double? sizeH;

  final double? activeSizeW;

  final double? activeSizeH;

  /// Space between rects
  final double space;

  final Key? key;

  const CustomRectSwiperPaginationBuilder(
      {this.activeColor,
      this.color,
      this.key,
      this.sizeW = 30,
      this.sizeH = 8,
      this.activeSizeW = 30,
      this.activeSizeH = 8,
      // this.size: const Size(10.0, 2.0),
      // this.activeSize: const Size(10.0, 2.0),
      this.space = 3.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    ThemeData themeData = Theme.of(context);
    Color activeColor = this.activeColor ?? themeData.primaryColor;
    Color color = this.color ?? themeData.scaffoldBackgroundColor;

    List<Widget> list = [];

    if (config.itemCount > 20) {
      print(
          "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
    }

    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    for (int i = 0; i < itemCount; ++i) {
      bool active = i == activeIndex;
      // Size size = active ? this.activeSize : this.size;
      list.add(SizedBox(
        width: active ? activeSizeW : sizeW,
        height: active ? activeSizeH : sizeH,
        child: Container(
          color: active ? activeColor : color,
          key: Key("pagination_$i"),
          margin: EdgeInsets.all(space),
        ),
      ));
    }

    if (config.scrollDirection == Axis.vertical) {
      return Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    } else {
      return Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }
  }
}
