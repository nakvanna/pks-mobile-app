import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/controllers/login-controller.dart';
import 'package:pks_mobile/routes/app_pages.dart';

class MyDrawer extends GetView {
  final List<Map<String, dynamic>> listItems = [
    {
      'onTap': () {},
      'image': 'assets/images/png/settings32.png',
      'label': 'settings',
    },
    {
      'onTap': () {},
      'image': 'assets/images/png/information32.png',
      'label': 'about-school',
    },
    {
      'onTap': () {},
      'image': 'assets/images/png/accurate32.png',
      'label': 'about-app',
    },
    {
      'onTap': () {},
      'image': 'assets/images/png/social-media32.png',
      'label': 'share',
    },
    {
      'onTap': () async {
        await Get.find<LoginController>().googleSignOut();
        Get.offAllNamed(Routes.AUTH);
      },
      'image': 'assets/images/png/logout32.png',
      'label': 'logout',
    },
  ];
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: size.height / 6,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.pinkAccent],
                ),
              ),
              child: ListTile(
                leading:
                    Image.asset("assets/images/png/profile-placeholder.png"),
                title: Text('NAK VANNA'),
                subtitle: Text('nakvanna@gmail.com'),
              ),
            ),
            Opacity(
              opacity: .75,
              child: Column(
                children: listItems
                    .map(
                      (e) => drawerMenu(
                        onTap: e['onTap'],
                        image: e['image'],
                        label: e['label'],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell drawerMenu(
      {required Function onTap, required String image, required String label}) {
    return InkWell(
      onTap: () => onTap(),
      child: ListTile(
        leading: Image.asset(image),
        title: Text(
          label.tr,
        ),
      ),
    );
  }
}
