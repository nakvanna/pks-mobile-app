import 'package:get/get.dart';
import 'package:pks_mobile/bindings/login_binding.dart';
import 'package:pks_mobile/screens/auth/auth_screen.dart';
import 'package:pks_mobile/screens/auth/verify_phone_number_screen.dart';
import 'package:pks_mobile/screens/home/home_screen.dart';
import 'package:pks_mobile/screens/splash/splash_screen.dart';

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
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: _Paths.VERIFY_PHONE_NUMBER,
      page: () => VerifyPhoneNumber(),
    ),
  ];
}
