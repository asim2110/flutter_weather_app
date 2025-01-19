import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/details_controller.dart';

class DetailsScreen extends StatelessWidget {
  final DetailsController controller = Get.find<DetailsController>();

  @override
  Widget build(BuildContext context) {
    final weather = controller.weather;

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(weather.cityName, style: TextStyle(fontSize: 24)),
            Text('${weather.temperature}°C', style: TextStyle(fontSize: 48)),
            Text(weather.description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
