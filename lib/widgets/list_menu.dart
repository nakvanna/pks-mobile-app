import 'package:flutter/material.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/helper/text-style/simple_text.dart';

class ListMenu extends StatelessWidget {
  const ListMenu({
    Key? key,
    required this.image,
    required this.titleLabel,
    this.subtitleLabel,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final String? subtitleLabel;
  final String image, titleLabel;
  final Function onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      leading: Image.asset(image),
      trailing: Icon(
        icon,
        color: kPrimaryColor,
      ),
      title: SimpleText(
        label: titleLabel,
        fontWeight: FontWeight.w700,
        color: kPrimaryColor,
      ),
      subtitle: subtitleLabel == null
          ? null
          : SimpleText(
              label: subtitleLabel!,
              fontWeight: FontWeight.w500,
              color: kPrimaryColor,
            ),
    );
  }
}
