import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/helper/text-style/title_text.dart';
import 'package:pks_mobile/routes/app_pages.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/background_app.dart';
import 'package:pks_mobile/widgets/custom_background.dart';
import 'package:pks_mobile/widgets/drawer.dart';
import 'package:pks_mobile/widgets/list_menu.dart';

class HomeScreen extends GetView {
  final List<Map<String, dynamic>> listMenuItems = [
    {
      'titleLabel': 'examination',
      'subtitleLabel': 'monthly-and-semester-by-subjects.',
      // 'onTap': Routes.AUTH,
      'onTap': () {
        print('Hello');
      },
      'icon': Icons.arrow_forward_ios,
      'image': 'assets/images/png/exam32.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    return AppBackground(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TitleText(
          label: 'ponlok-khmer-school',
          color: kSecondaryColor,
        ),
        actions: [
          IconButton(
            onPressed: () async {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      widget: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultSize),
          child: Column(
            children: listMenuItems
                .map(
                  (e) => ListMenu(
                    image: e['image'],
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
