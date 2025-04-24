import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  // Geolokatsiyani tekshirib, joylashuv nomini olish
  Future<String> getLocationName(double latitude, double longitude) async {
    final url = 'https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longitude&format=json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['address'] != null) {
          return data['address']['county'] ?? data['address']['city'] ?? 'Location not found';
        }
      }
      return 'Error retrieving location';
    } catch (e) {
      return 'Failed to get location';
    }
  }

  // Ob-havo ma'lumotlarini olish (Open-Meteo API dan foydalanish)
  Future<Map<String, dynamic>> getWeatherData(double latitude, double longitude) async {
    final url = 'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['current_weather'];
      }
      return {};
    } catch (e) {
      return {};
    }
  }
}
