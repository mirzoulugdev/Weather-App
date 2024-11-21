part of 'weather_cubit.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded(this.weather);
}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}
