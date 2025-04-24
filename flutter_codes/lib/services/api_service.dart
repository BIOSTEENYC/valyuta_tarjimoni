import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = "https://api.exchangerate-api.com/v4/latest"; // API

  // Valyuta kurslarini olish
  Future<Map<String, dynamic>> getExchangeRates(String baseCurrency) async {
    final url = Uri.parse('$_baseUrl/$baseCurrency');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Valyuta kurslarini olishda xatolik');
      }
    } catch (e) {
      throw Exception('API bilan ulanishda xatolik: $e');
    }
  }
}
