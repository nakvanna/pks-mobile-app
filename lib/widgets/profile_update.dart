import 'package:flutter/material.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/size_config.dart';

class ProfileUpdate extends StatelessWidget {
  const ProfileUpdate({
    Key? key,
    required this.photoURL,
    required this.onPressed,
  }) : super(key: key);

  final String photoURL;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    double screenWidth = SizeConfig.screenWidth!;
    return Stack(
      children: [
        Align(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: photoURL != ''
                ? Container(
                    color: kPrimaryColor,
                    child: Image.network(
                      photoURL,
                      width: defaultSize * 10,
                      height: defaultSize * 10,
                    ),
                  )
                : Image.asset(
                    'assets/images/png/profile-placeholder.png',
                    width: defaultSize * 10,
                    height: defaultSize * 10,
                  ),
          ),
        ),
        Positioned(
          top: defaultSize * 6,
          left: screenWidth / 2.2,
          child: IconButton(
            onPressed: () => onPressed(),
            icon: Icon(Icons.camera_alt),
          ),
        ),
      ],
    );
  }
}
