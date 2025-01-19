import 'package:flutter/material.dart';
import '../services/location_services.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService weatherService = WeatherService();
  final LocationService locationService = LocationService();
  Weather? currentWeather;
  String? errorMessage;
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeatherByLocation();
  }

  // Fetch weather based on the city name
  Future<void> _fetchWeatherByCity(String cityName) async {
    try {
      final weather = await weatherService.fetchWeatherByCity(cityName);
      setState(() {
        currentWeather = weather;
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch weather for $cityName: $e';
      });
    }
  }

  // Fetch weather based on the user's current location
  Future<void> _fetchWeatherByLocation() async {
    try {
      final position = await locationService.getCurrentLocation();
      final weather = await weatherService.fetchWeatherByLocation(
        position.latitude,
        position.longitude,
      );
      setState(() {
        currentWeather = weather;
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch weather: $e';
      });
    }
  }

  // Refresh weather data when pulled down
  Future<void> _refreshWeather() async {
    await _fetchWeatherByLocation();
  }

  // Widget to display weather information
  Widget _weatherInfo() {
    if (currentWeather == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        children: [
          Text(
            'City: ${currentWeather!.cityName}',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wb_sunny, color: Colors.orange, size: 40),
              SizedBox(width: 12),
              Text(
                '${currentWeather!.temperature}°C',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Condition: ${currentWeather!.description}',
            style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  // Widget for search input field
  Widget _searchInputField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)],
      ),
      child: TextField(
        controller: cityController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintText: 'Search for a city',
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(Icons.search, color: Colors.blueAccent),
            onPressed: () {
              String cityName = cityController.text;
              if (cityName.isNotEmpty) {
                _fetchWeatherByCity(cityName);
              }
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Widget for search button
  // Widget for search button
  Widget _searchButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      onPressed: () {
        String cityName = cityController.text;
        if (cityName.isNotEmpty) {
          _fetchWeatherByCity(cityName);
          cityController.clear(); // Clear the text field after search
        }
      },
      child: Text('Search Weather by City', style: TextStyle(fontSize: 18)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App', style: TextStyle(fontSize: 26)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshWeather, // Trigger the refresh when pulled down
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _weatherInfo(), // Display weather info
            SizedBox(height: 30),
            _searchInputField(), // Search input field
            SizedBox(height: 20),
            _searchButton(), // Search button
          ],
        ),
      ),
    );
  }
}
