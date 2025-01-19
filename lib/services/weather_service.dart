import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const _apiKey = 'ccd48e76f52e2f35be2f346a3eaff52c';
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  /// Fetch weather by city name
  Future<Weather> fetchWeatherByCity(String cityName) async {
    final url = '$_baseUrl?q=$cityName&appid=$_apiKey&units=metric';
    return _fetchWeather(url, "City");
  }

  /// Fetch weather by latitude and longitude
  Future<Weather> fetchWeatherByLocation(double lat, double lon) async {
    final url = '$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric';
    return _fetchWeather(url, "Location");
  }

  /// Common method to fetch weather data
  Future<Weather> _fetchWeather(String url, String fetchType) async {
    print('Request URL: $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('Response Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final data = json.decode(response.body);
          return Weather.fromJson(data);
        } catch (parsingError) {
          print('Error parsing the weather data: $parsingError');
          throw Exception('Failed to parse weather data for $fetchType.');
        }
      } else if (response.statusCode == 404) {
        throw Exception('No data found for the given $fetchType.');
      } else {
        throw Exception('Failed to fetch weather data for $fetchType. Error code: ${response.statusCode}');
      }
    } catch (networkError) {
      print('Network error while fetching weather data: $networkError');
      throw Exception('Failed to fetch weather data for $fetchType due to network issues.');
    }
  }
}
