import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: CircularProgressIndicator()));
  }
}
