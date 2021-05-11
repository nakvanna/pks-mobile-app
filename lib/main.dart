import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/bindings/shared-prefs-binding.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:pks_mobile/controllers/db_controller.dart';
import 'package:pks_mobile/controllers/shared-prefs-controller.dart';
import 'package:pks_mobile/controllers/translator_controller.dart';
import 'package:pks_mobile/helper/split_and_join/split_locale_code.dart';
import 'package:pks_mobile/routes/app_pages.dart';
import 'package:pks_mobile/translations/translator.dart';

bool userFirestoreEmulator = false;

void main() async {
  ///Using to interact with the Flutter engine
  WidgetsFlutterBinding.ensureInitialized();
  //Initialize firebase core
  await Firebase.initializeApp();
  if (userFirestoreEmulator) {
    FirebaseFirestore.instance.settings = const Settings(
      host: '10.0.2.2:8080',
      sslEnabled: false,
      persistenceEnabled: false,
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.//

  final _authUser = FirebaseAuth.instance.currentUser; //Authentication
  final _translation = TranslationController(); //Translate init

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onInit: () async {
        Get.put(DbController());

        ///Delay for splash screen
        Future.delayed(Duration(seconds: 3), () {
          String _langCode = getLangCode(localeCode: kLocaleCode.value);
          String _countryCode = getCountryCode(localeCode: kLocaleCode.value);

          Get.find<SharedPrefsController>()
              .getLocaleCode(); //Get locale code from locale storage
          Get.find<SharedPrefsController>()
              .getUID(); //Get uid from locale storage

          _translation.changeLanguage(
            langCode: _langCode,
            countryCode: _countryCode,
          ); //Change language on splash screen duration

          ///Check login or not and go to route
          return _authUser == null
              ? Get.offNamed(Routes.AUTH)
              : Get.offNamed(Routes.HOME);
        });
      },
      title: 'PKS MOBILE',
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: kPrimaryColor,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: kPrimaryColor,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
        ),
      ),
      locale: Locale('kh', 'KH'), //Default locale
      // fallbackLocale: Locale('kh', 'KH'), //Fall back locale
      initialBinding:
          SharedPrefsBinding(), //Binding shared preference dependency injection
      translations: Translator(), //Call translator
      defaultTransition:
          Transition.rightToLeftWithFade, //Default transition each route
      initialRoute: AppPages.INITIAL, //Initialize first route
      getPages: AppPages.routes, //List all routes
    );
  }
}
