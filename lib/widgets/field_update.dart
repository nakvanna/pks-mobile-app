import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FieldUpdate extends StatelessWidget {
  const FieldUpdate({
    Key? key,
    required this.fromKey,
    required this.validate,
    required this.textEditingController,
    required this.onSave,
    required this.hintText,
    required this.preIconData,
    required this.onPressed,
    required this.sufIconData,
  }) : super(key: key);

  final GlobalKey<FormState> fromKey;
  final String? Function(String value) validate;
  final TextEditingController textEditingController;
  final Function(String value) onSave;
  final String hintText;
  final IconData preIconData;
  final Function onPressed;
  final IconData sufIconData;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: fromKey,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              validator: ((value) => validate(value!)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: textEditingController,
              onSaved: ((value) => onSave(value!)),
              decoration: InputDecoration(
                hintText: hintText.tr,
                prefixIcon: Icon(preIconData),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              onPressed();
              textEditingController.clear(); //NEED CLEAR
            },
            icon: Icon(sufIconData),
          ),
        ],
      ),
    );
  }
}
