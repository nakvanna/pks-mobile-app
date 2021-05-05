import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants.dart';
import 'package:pks_mobile/routes/app_pages.dart';
import 'package:pks_mobile/translations/translator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: () async {
        ///Delay for splash screen
        Future.delayed(
          Duration(seconds: 2),
          () => Get.offNamed(Routes.AUTH),
        );
      },
      title: 'PKS MOBILE',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: kPrimaryColor,
      ),
      locale: Locale('kh', 'KH'),
      // fallbackLocale: Locale('kh', 'KH'),
      translations: Translator(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
