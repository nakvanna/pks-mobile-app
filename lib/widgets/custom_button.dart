import 'package:flutter/material.dart';
import 'package:pks_mobile/helper/text-styles/button_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.btnColor,
    required this.labelColor,
    required this.width,
    required this.height,
    this.icon,
  }) : super(key: key);

  final Function onPressed;
  final String label;
  final Color btnColor, labelColor;
  final double width, height;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ButtonTheme(
        child: icon == null
            ? FlatButton(
                onPressed: () => onPressed(),
                child: Center(
                  child: ButtonText(
                    label: label,
                    color: labelColor,
                  ),
                ),
              )
            : FlatButton.icon(
                icon: icon!,
                onPressed: () => onPressed(),
                label: Center(
                  child: ButtonText(
                    label: label,
                    color: labelColor,
                  ),
                ),
              ),
      ),
    );
  }
}
