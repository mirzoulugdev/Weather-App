import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/screens/search_screen.dart';

import '../widgets/city_part.dart';
import '../widgets/temperature_part.dart';

import '/logic/weather_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _getWeather('london');
  }

  void _getWeather(String city) async {
    context.read<WeatherCubit>().getWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) async {
          if (state is WeatherError) {
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
            if (state.message.toLowerCase().contains("not found")) {
              _getWeather('london');
            }
          }
        },
        builder: (ctx, state) {
          if (state is WeatherInitial) {
            return const Text("Select the city name");
          }
          if (state is WeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WeatherLoaded) {
            final weather = state.weather;
            final mainWeather = weather.main.toLowerCase();
            String imagePath = '';
            if (mainWeather.contains("rain")) {
              imagePath = 'assets/images/rainy.png';
            } else if (mainWeather.contains('cloud')) {
              imagePath = "assets/images/cloudy.png";
            } else if (mainWeather.contains("sun") ||
                mainWeather.contains("clear")) {
              imagePath = "assets/images/sunny.png";
            } else {
              imagePath = "assets/images/night.png";
            }
            return Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        imagePath,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: Colors.black.withOpacity(0.5),
                ),
                Positioned(
                  right: 5,
                  top: 50,
                  child: IconButton(
                    onPressed: () async {
                      final city = await Navigator.of(context)
                          .pushNamed(SearchScreen.routeName);

                      if (city != null) {
                        _getWeather(city as String);
                      }
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CityPart(weather: weather),
                        TemperaturePart(weather: weather),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
