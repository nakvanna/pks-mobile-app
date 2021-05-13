import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/helper/text-styles/simple_text.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/field_update.dart';

//TODO prepare again tomorrow
//For email and phone
class UpdateListFields extends GetView {
  const UpdateListFields({
    Key? key,
    required this.listItems,
    required this.formKey,
    required this.validate,
    required this.textEditingController,
    required this.title,
    required this.mapField,
    required this.onPressedAdd,
    required this.onPressedRemove,
    required this.preIcon,
    required this.sufIcon,
  }) : super(key: key);

  final RxList listItems;
  final GlobalKey<FormState> formKey;
  final String? Function(String value) validate;
  final TextEditingController textEditingController;
  final String title;
  final String mapField;
  final Function onPressedAdd;
  final Function(int index) onPressedRemove;
  final IconData preIcon, sufIcon;
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    return Obx(
      () => ExpansionTile(
        title: SimpleText(
          label: title,
          color: kPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
        children: <Widget>[
          for (int i = 0; i < listItems.length; i++)
            if (listItems[i]['type'] == 'primary')
              Padding(
                padding: EdgeInsets.only(
                  left: defaultSize,
                  right: defaultSize,
                ),
                child: Row(
                  children: [
                    SimpleText(
                      label: listItems[i][mapField],
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: defaultSize,
                    ),
                    Icon(
                      Icons.verified_outlined,
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: EdgeInsets.only(
                  left: defaultSize,
                  right: defaultSize,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleText(
                      label: listItems[i][mapField],
                      color: kPrimaryColor,
                    ),
                    IconButton(
                      onPressed: () => onPressedRemove(i),
                      icon: Icon(
                        Icons.delete_outlined,
                        color: kInactiveColor,
                      ),
                    )
                  ],
                ),
              ),
          FieldUpdate(
            fromKey: formKey,
            validate: ((value) => validate(value)),
            textEditingController: textEditingController,
            onSave: ((value) => listItems.add({
                  mapField: value.toLowerCase(),
                  'type': 'secondary',
                })),
            hintText: 'add-more...',
            preIconData: preIcon,
            onPressed: () => onPressedAdd(),
            sufIconData: sufIcon,
          ),
        ],
      ),
    );
  }
}
