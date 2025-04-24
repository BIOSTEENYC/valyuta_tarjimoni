import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final String location;

  const LocationCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          location,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
