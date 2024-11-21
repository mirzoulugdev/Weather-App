import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather.dart';

class CityPart extends StatelessWidget {
  final Weather weather;
  const CityPart({required this.weather, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          weather.city[0].toUpperCase() + weather.city.substring(1),
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          weather.description[0].toUpperCase() +
              weather.description.substring(1),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
