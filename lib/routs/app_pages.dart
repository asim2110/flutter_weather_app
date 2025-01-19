import 'package:get/get.dart';
import 'package:weather_app/screens/details_screen.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/bindings/home_binding.dart';
import 'package:weather_app/bindings/details_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.details,
      page: () => DetailsScreen(),
      binding: DetailsBinding(),
    ),
  ];
}
