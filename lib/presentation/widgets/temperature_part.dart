import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather.dart';

class TemperaturePart extends StatelessWidget {
  final Weather weather;
  const TemperaturePart({required this.weather, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${weather.temperature.toStringAsFixed(0)}℃",
          style: const TextStyle(
            fontSize: 70,
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Image.network(
                "https://openweathermap.org/img/wn/${weather.icon}@2x.png"),
            Text(
              weather.main,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
