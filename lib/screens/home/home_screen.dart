import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/controllers/db_controller.dart';
import 'package:pks_mobile/helper/text-styles/title_text.dart';
import 'package:pks_mobile/routes/app_pages.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/app_background.dart';
import 'package:pks_mobile/widgets/drawer.dart';
import 'package:pks_mobile/widgets/list_menu.dart';

class HomeScreen extends GetView<DbController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listMenuItems = [
      {
        'titleLabel': 'examination',
        'subtitleLabel': 'monthly-and-semester-by-subjects.',
        // 'onTap': Routes.AUTH,
        'onTap': () async {
          print('Exam here!');
        },
        'icon': Icons.arrow_forward_ios,
        'image': 'assets/images/png/exam32.png',
      },
      {
        'titleLabel': 'Auth Current Users',
        'subtitleLabel': 'monthly-and-semester-by-subjects.',
        // 'onTap': Routes.AUTH,
        'onTap': () async {
          print(FirebaseAuth.instance.currentUser!);
        },
        'icon': Icons.arrow_forward_ios,
        'image': 'assets/images/png/exam32.png',
      },
      {
        'titleLabel': 'Read Users',
        'subtitleLabel': 'monthly-and-semester-by-subjects.',
        // 'onTap': Routes.AUTH,
        'onTap': () async {
          await controller.readUsers();
        },
        'icon': Icons.arrow_forward_ios,
        'image': 'assets/images/png/exam32.png',
      },
    ];
    double defaultSize = SizeConfig.defaultSize!;
    return AppBackground(
      scaffoldKey: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: TitleText(
          label: 'ponlok-khmer-school',
          color: kPrimaryColor,
        ),
        leading: IconButton(
          icon: Image.asset('assets/images/png/list32.png'),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.USER_LIST);
            },
            icon: Image.asset('assets/images/png/ellipsis32.png'),
          ),
        ],
      ),
      drawer: MyDrawer(),
      widget: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultSize),
          child: Column(
            children: listMenuItems
                .map(
                  (e) => ListMenu(
                    image: Image.asset(e['image']),
                    titleLabel: e['titleLabel'],
                    subtitleLabel: e['subtitleLabel'],
                    onTap: e['onTap'],
                    icon: e['icon'],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
