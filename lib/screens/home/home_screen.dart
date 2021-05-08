import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/helper/text-style/title_text.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/app_background.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    return AppBackground(
      scaffoldKey: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: TitleText(
          label: 'ponlok-khmer-school',
          color: kPrimaryColor,
        ),
        leading: IconButton(
          icon: Image.asset('assets/images/png/menu32.png'),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('more vertical');
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
