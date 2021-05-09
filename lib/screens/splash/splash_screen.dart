import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/controllers/db_controller.dart';
import 'package:pks_mobile/size_config.dart';

class SplashScreen extends GetView<DbController> {
  @override
  Widget build(BuildContext context) {
    ///init size config for text style
    SizeConfig().init(context);
    ///Init user info from fire-store
    
    return Center(child: Image.asset('assets/images/gif/loading-screen.gif'));
  }
}
