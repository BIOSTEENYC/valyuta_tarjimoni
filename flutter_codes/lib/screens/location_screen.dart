import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_icons/weather_icons.dart';

import '../services/location_service.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  String locationName = "Loading...";
  String temperature = "Loading...";
  String weatherDescription = "Loading...";
  IconData weatherIcon = WeatherIcons.na;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getLocationAndWeather();
  }

  // Ob-havo kodiga mos ikonkani tanlash
  IconData _getWeatherIcon(int weatherCode) {
    switch (weatherCode) {
      case 0: // Clear sky
        return WeatherIcons.day_sunny;
      case 1: // Mainly clear
      case 2: // Partly cloudy
      case 3: // Overcast
        return WeatherIcons.day_cloudy;
      case 45: // Fog
      case 48: // Depositing rime fog
        return WeatherIcons.fog;
      case 51: // Drizzle: Light
      case 53: // Drizzle: Moderate
      case 55: // Drizzle: Dense intensity
      case 56: // Freezing Drizzle: Light
      case 57: // Freezing Drizzle: Dense intensity
        return WeatherIcons.sprinkle;
      case 61: // Rain: Slight
      case 63: // Rain: Moderate
      case 65: // Rain: Heavy intensity
        return WeatherIcons.rain;
      case 66: // Freezing Rain: Light
      case 67: // Freezing Rain: Heavy intensity
        return WeatherIcons.rain_mix;
      case 71: // Snow fall: Slight
      case 73: // Snow fall: Moderate
      case 75: // Snow fall: Heavy intensity
        return WeatherIcons.snow;
      case 77: // Snow grains
        return WeatherIcons.snow_wind;
      case 80: // Rain showers: Slight
      case 81: // Rain showers: Moderate
      case 82: // Rain showers: Violent
        return WeatherIcons.showers;
      case 85: // Snow showers slight
      case 86: // Snow showers heavy
        return WeatherIcons.snow;
      case 95: // Thunderstorm: Slight or moderate
        return WeatherIcons.thunderstorm;
      case 96: // Thunderstorm with slight hail
      case 99: // Thunderstorm with heavy hail
        return WeatherIcons.storm_showers;
      default:
        return WeatherIcons.na;
    }
  }

  _getLocationAndWeather() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Joylashuv nomini olish
    var location = await LocationService().getLocationName(position.latitude, position.longitude);

    // Ob-havo ma'lumotlarini olish
    var weatherData = await LocationService().getWeatherData(position.latitude, position.longitude);
    int weatherCode = weatherData['weathercode'];
    setState(() {
      locationName = location;
      temperature = weatherData['temperature'].toString();
      weatherDescription = weatherCode.toString(); // Open-Meteo API'dan kelgan ma'lumotlar
      weatherIcon = _getWeatherIcon(weatherCode); // Ikonkani tanlash
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade300, // Kun uchun rang
              Colors.blue.shade900, // Kun uchun rang
            ],
          ),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.white.withOpacity(0.3),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      'Weather NOW',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Text(
                      locationName,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$temperature°C',
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Icon(
                      weatherIcon,
                      size: 50,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}