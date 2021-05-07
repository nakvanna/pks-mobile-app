import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/size_config.dart';

class SplashScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    ///init size config for text style
    SizeConfig().init(context);
    return Center(child: Image.asset('assets/images/gif/loading-screen.gif'));
  }
}
