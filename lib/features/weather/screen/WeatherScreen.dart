import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather24x7/features/weather/service/WeatherService.dart';
import 'package:weather24x7/models/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService('OPEN WEATHER API APP KEY');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final Weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = Weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWetherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/weather/sunny.json';
    } else {
      switch (mainCondition.toLowerCase()) {
        case 'clouds':
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'fog':
          return 'assets/weather/cloudy.json';
        case 'rain':
        case 'drizzle':
        case 'shower rain':
          return 'assets/weather/ranny.json';
        case 'thunderstorm':
          return 'assets/weather/thunder.json';
        case 'clear':
          return 'assets/weather/sunny.json';
        default:
          return 'assets/weather/sunny.json';
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              SizedBox(
                  height: 50,
                  width: 50,
                  child: Lottie.asset('assets/weather/location.json',
                      fit: BoxFit.cover)),
              SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Text(_weather?.cityName ?? 'loading city ..', style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w700),),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                  height: 150,
                  width: 300,
                  child: Lottie.asset(getWetherAnimation(_weather?.mainCondition),
                      fit: BoxFit.cover)),
              const SizedBox(height: 50),
              const Spacer(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${_weather?.temperature.round().toString()}°C',style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 40),),
                ),
                        
              ),
              SizedBox(
                child: Text(_weather?.mainCondition ?? '',style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w700),),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
