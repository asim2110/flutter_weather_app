import 'package:get/get.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var weather = Rxn<Weather>();

  final WeatherService _weatherService = WeatherService();

  /// Fetch weather by city name
  void fetchWeather(String cityName) async {
    try {
      isLoading(true);
      weather.value = await _weatherService.fetchWeatherByCity(cityName);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Fetch weather by location (latitude & longitude)
  void fetchWeatherByLocation(double lat, double lon) async {
    try {
      isLoading(true);
      weather.value = await _weatherService.fetchWeatherByLocation(lat, lon);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
