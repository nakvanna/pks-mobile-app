import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';

class AppBackground extends GetView {
  AppBackground({
    required this.widget,
    this.drawer,
    this.appBar,
    this.others,
  });

  final Widget? widget;
  final Widget? drawer;
  final Widget? appBar;
  final Widget? others;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: kBgColors,
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(maxHeight: double.infinity),
                    ),
                  ),
                  Image.asset(
                    'assets/images/png/building.png',
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              widget!,
            ],
          ),
        ),
      ),
    );
  }
}
