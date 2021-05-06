import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/controllers/login-controller.dart';
import 'package:pks_mobile/routes/app_pages.dart';
import 'package:pks_mobile/widgets/custom_background.dart';

class HomeScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return customBackground(
      colors: kBgHomeScreen,
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      scaffold: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('home-screen'),
          actions: [
            IconButton(
              onPressed: () async {
                await Get.find<LoginController>().googleSignOut();
                Get.offAllNamed(Routes.AUTH);
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
