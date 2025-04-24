import 'package:flutter/material.dart';
class CurrencyDropdown extends StatelessWidget {
  final String value;
  final List<String> currencies;
  final ValueChanged<String?> onChanged;

  const CurrencyDropdown({
    super.key,
    required this.value,
    required this.currencies,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      onChanged: onChanged,
      items: currencies
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
