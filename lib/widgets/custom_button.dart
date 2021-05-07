import 'package:flutter/material.dart';
import 'package:pks_mobile/helper/text-style/button_text.dart';
import 'package:pks_mobile/size_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.color,
  }) : super(key: key);

  final Function onPressed;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    double screenWith = SizeConfig.screenWidth!;
    return Container(
      width: screenWith,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ButtonTheme(
        height: defaultSize * 5,
        child: FlatButton(
          onPressed: () => onPressed(),
          child: Center(
            child: ButtonText(
              label: label,
            ),
          ),
        ),
      ),
    );
  }
}
