// class Weather {
//   final String cityName;
//   final double temperature;
//   final String description;
//
//   Weather({
//     required this.cityName,
//     required this.temperature,
//     required this.description,
//   });
//
//   factory Weather.fromJson(Map<String, dynamic> json) {
//     return Weather(
//       cityName: json['name'],
//       temperature: json['main']['temp'],
//       description: json['weather'][0]['description'],
//     );
//   }
// }
class Weather {
  final String cityName;
  final double temperature;
  final String description;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    try {
      // Handling 'int' or 'double' for temperature
      double temp = json['main']['temp'] is int
          ? (json['main']['temp'] as int).toDouble()
          : json['main']['temp'] as double;

      return Weather(
        cityName: json['name'],
        temperature: temp,
        description: json['weather'][0]['description'],
      );
    } catch (e) {
      print('Error parsing weather data: $e');
      rethrow;
    }
  }
}
