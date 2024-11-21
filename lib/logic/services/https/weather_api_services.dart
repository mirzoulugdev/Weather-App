import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/logic/services/exceptions/weather_exceptions.dart';
import '/data/constants/constants.dart';

class WeatherApiServices {
  final http.Client client;
  WeatherApiServices({required this.client});

  Future<Weather> getWeather(String city) async {
    final url = Uri.parse(
        "$baseUrl?q=${city.toLowerCase()}&units=metric&appid=$apiKey");

    try {
      final response = await client.get(url);

      if (response.statusCode >= 400) {
        throw Exception(response.reasonPhrase);
      }
      final responseBody = jsonDecode(response.body);

      if (responseBody == null) {
        throw WeatherExceptions("Cannot get weather fo $city");
      }

      final data = responseBody as Map<String, dynamic>;
      final weatherData = data['weather'][0];
      final mainData = data['main'];

      final Weather weather = Weather(
        id: weatherData['id'].toString(),
        main: weatherData['main'],
        description: weatherData['description'],
        icon: weatherData['icon'],
        temperature: double.parse(mainData['temp'].toString()),
        city: city,
      );

      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
