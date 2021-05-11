import 'package:flutter/material.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/helper/text-styles/simple_text.dart';
import 'package:pks_mobile/helper/validates/form_validate.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:get/get.dart';

class FieldUpdate extends StatelessWidget {
  FieldUpdate({
    Key? key,
    required this.fieldController,
    required this.onPressed,
    this.hintText: 'change-to...',
    required this.preIcon,
    required this.sufIcon,
    required this.valueShow,
    this.validateLength: 5,
    this.emptyValueText: 'value-empty',
  }) : super(key: key);

  final TextEditingController fieldController;
  final Function onPressed;
  final String hintText, valueShow, emptyValueText;
  final IconData preIcon, sufIcon;
  final int validateLength;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    return ExpansionTile(
      onExpansionChanged: (val) {
        print(val);
      },
      title: valueShow != ''
          ? SimpleText(
              label: valueShow,
              color: kPrimaryColor,
            )
          : SimpleText(
              label: emptyValueText,
              color: kPrimaryColor,
            ),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(defaultSize),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: ((value) => kFieldLengthValidate(
                        length: validateLength,
                        field: value!,
                      )),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: fieldController,
                  decoration: InputDecoration(
                    hintText: hintText.tr,
                    prefixIcon: Icon(preIcon),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => onPressed(),
                icon: Icon(sufIcon),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
