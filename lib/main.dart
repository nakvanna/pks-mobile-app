import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/bindings/login_binding.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/constants/user_info.dart';
import 'package:pks_mobile/routes/app_pages.dart';
import 'package:pks_mobile/translations/translator.dart';

void main() async {
  ///Using to interact with the Flutter engine
  WidgetsFlutterBinding.ensureInitialized();
  //Initialize firebase core
  await Firebase.initializeApp();
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
          () => googleUser.value == null
              ? Get.offNamed(Routes.AUTH)
              : Get.offNamed(Routes.HOME),
        );
      },
      title: 'PKS MOBILE',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: kPrimaryColor,
      ),
      locale: Locale('kh', 'KH'),
      initialBinding: LoginBinding(),
      // fallbackLocale: Locale('kh', 'KH'),
      translations: Translator(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
