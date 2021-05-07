import 'package:flutter/material.dart';
import 'package:pks_mobile/helper/text-style/simple_text.dart';

class ListMenu extends StatelessWidget {
  const ListMenu({
    Key? key,
    required this.image,
    required this.titleLabel,
    required this.subtitleLabel,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final String image, titleLabel, subtitleLabel;
  final Function onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      leading: Image.asset(image),
      trailing: Icon(icon),
      title: SimpleText(
        label: titleLabel,
        fontWeight: FontWeight.w700,
      ),
      subtitle: SimpleText(
        label: subtitleLabel,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}