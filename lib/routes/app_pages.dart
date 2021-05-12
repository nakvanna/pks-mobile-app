import 'package:get/get.dart';
import 'package:pks_mobile/bindings/db_binding.dart';
import 'package:pks_mobile/bindings/login_binding.dart';
import 'package:pks_mobile/bindings/translator_binding.dart';
import 'package:pks_mobile/screens/auth/auth_screen.dart';
import 'package:pks_mobile/screens/auth/verify_phone_number_screen.dart';
import 'package:pks_mobile/screens/drawers/settings/language/laguage_screen.dart';
import 'package:pks_mobile/screens/drawers/settings/personal_info/view/personal_info_screen.dart';
import 'package:pks_mobile/screens/drawers/settings/setting_screen.dart';
import 'package:pks_mobile/screens/home/home_screen.dart';
import 'package:pks_mobile/screens/splash/splash_screen.dart';
import 'package:pks_mobile/screens/user_list/user_list_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
      binding: DbBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthScreen(),
      bindings: [LoginBinding(), DbBinding()],
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreen(),
      bindings: [LoginBinding(), DbBinding()],
    ),
    GetPage(
      name: _Paths.VERIFY_PHONE_NUMBER,
      page: () => VerifyPhoneNumber(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => Settings(),
    ),
    GetPage(
      name: _Paths.LANGUAGES,
      page: () => Languages(),
      binding: TranslationBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFO,
      page: () => PersonalInfo(),
      binding: DbBinding(),
    ),
    GetPage(
      name: _Paths.USER_LIST,
      page: () => UserList(),
      binding: DbBinding(),
    ),
  ];
}
