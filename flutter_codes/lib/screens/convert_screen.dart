// lib/screens/converter_screen.dart

import 'package:flutter/material.dart';
import 'package:currency_converter/services/api_service.dart';
import 'package:currency_converter/widgets/currency_dropdown.dart';
import 'package:currency_converter/widgets/convert_button.dart';
import 'package:intl/intl.dart'; // NumberFormat uchun

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  ConverterScreenState createState() => ConverterScreenState();
}

class ConverterScreenState extends State<ConverterScreen> {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String _baseCurrency = 'USD';
  String _targetCurrency = 'UZS';
  double _amount = 100.0;
  String _result = '';

  Future<void> _fetchRates() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await _apiService.getExchangeRates(_baseCurrency);
      final exchangeRate = data['rates'][_targetCurrency];
      final convertedAmount = _amount * exchangeRate;
      final formattedAmount = NumberFormat("#,##0.00", "en_US").format(convertedAmount); // Raqamni formatlash
      setState(() {
        _result = '$formattedAmount $_targetCurrency'; // Formatlangan raqamni ko'rsatish
      });
    } catch (e) {
      setState(() {
        _result = 'Xatolik: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _swapCurrencies() {
    setState(() {
      final temp = _baseCurrency;
      _baseCurrency = _targetCurrency;
      _targetCurrency = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CloseButton(onPressed: (){Navigator.pop(context);},color: Colors.red,),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CurrencyDropdown(
                        value: _baseCurrency,
                        currencies: const ['UZS','USD', 'EUR', 'RUB', 'KGS', 'TJS'],
                        onChanged: (newValue) {
                          setState(() {
                            _baseCurrency = newValue!;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.swap_horiz),
                      onPressed: _swapCurrencies,
                    ),
                    Expanded(
                      flex: 1,
                      child: CurrencyDropdown(
                        value: _targetCurrency,
                        currencies: const ['UZS','USD', 'EUR', 'RUB', 'KGS', 'TJS'],
                        onChanged: (newValue) {
                          setState(() {
                            _targetCurrency = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Miqdorni kiriting',
                    prefixIcon: const Icon(Icons.attach_money),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _amount = double.tryParse(value) ?? 0.0;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ConvertButton(
                  isLoading: _isLoading,
                  onPressed: _fetchRates,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 20),
                if (_result.isNotEmpty)
                  Text(
                    'Converted Amount: $_result',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}