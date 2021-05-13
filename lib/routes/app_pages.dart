import 'package:get/get.dart';
import 'package:pks_mobile/bindings/login_binding.dart';
import 'package:pks_mobile/bindings/translator_binding.dart';
import 'package:pks_mobile/screens/auth/auth_screen.dart';
import 'package:pks_mobile/screens/auth/verify_phone_number_screen.dart';
import 'package:pks_mobile/screens/drawers/binding/my_drawer_binding.dart';
import 'package:pks_mobile/screens/drawers/subs/settings/language/laguage_screen.dart';
import 'package:pks_mobile/screens/drawers/subs/settings/personal_info/binding/personal_info_binding.dart';
import 'package:pks_mobile/screens/drawers/subs/settings/personal_info/view/personal_info_screen.dart';
import 'package:pks_mobile/screens/drawers/subs/settings/setting_screen.dart';
import 'package:pks_mobile/screens/home/home_screen.dart';
import 'package:pks_mobile/screens/splash/splash_screen.dart';
import 'package:pks_mobile/screens/user_list/binding/user_list_binding.dart';
import 'package:pks_mobile/screens/user_list/view/user_list_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreen(),
      bindings: [LoginBinding(), DrawerBinding()],
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
      binding: PersonalInfoBinding(),
    ),
    GetPage(
        name: _Paths.USER_LIST,
        page: () => UserList(),
        binding: UserListBinding()),
  ];
}
