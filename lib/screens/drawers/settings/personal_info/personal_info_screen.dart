import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/controllers/db_controller.dart';
import 'package:pks_mobile/helper/text-styles/title_text.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/app_background.dart';

class PersonalInfo extends GetView<DbController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    return AppBackground(
      appBar: AppBar(
        centerTitle: true,
        title: TitleText(
          label: 'personal-info',
          color: kPrimaryColor,
        ),
      ),
      widget: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultSize),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 15.0),
                      blurRadius: 15.0,
                    ),
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, -10.0),
                      blurRadius: 10.0,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(defaultSize),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'username'.tr,
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'username'.tr,
                          ),
                        ),
                        SizedBox(
                          height: defaultSize,
                        ),
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'username'.tr,
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'username'.tr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
