import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  WeatherCard({required this.weather});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/details', arguments: weather);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(weather.cityName, style: TextStyle(fontSize: 24)),
              Text('${weather.temperature}°C', style: TextStyle(fontSize: 48)),
              Text(weather.description, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
