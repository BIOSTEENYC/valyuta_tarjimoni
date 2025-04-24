import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  // Foydalanuvchining latitudasi va longitudasi bo'yicha ob-havo ma'lumotlarini olish
  Future<Map<String, dynamic>> fetchWeatherData(double latitude, double longitude) async {
    final url = Uri.parse('$_baseUrl?latitude=$latitude&longitude=$longitude&current_weather=true');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
