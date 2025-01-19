import 'package:get/get.dart';
import '../models/weather_model.dart';

class DetailsController extends GetxController {
  final Weather weather = Get.arguments as Weather;
}
