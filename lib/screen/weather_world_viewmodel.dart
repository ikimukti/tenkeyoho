import 'package:flutter/material.dart';
import 'package:tenkoyoho2/model/api/weather_api.dart';
// import 'package:tenkoyoho2/model/api/weather_user_api.dart';
// import 'package:tenkoyoho2/model/weather2_model.dart';

import 'package:tenkoyoho2/model/weather_model.dart';

class WeatherWorldViewModel with ChangeNotifier {
  final List<WeatherModel> _weathers = [];

  List<WeatherModel> get weathers => _weathers;

  bool repeat = true;
  getAllWeathers() async {
    List<Map> locationListWorld = [
      {
        'city': 'New York',
        'code': 'US',
        'lat': 40.7128,
        'lon': -74.0060,
      },
      {
        'city': 'Jakarta',
        'code': 'ID',
        'lat': -6.1751,
        'lon': 106.8455,
      },
      {
        'city': 'London',
        'code': 'GB',
        'lat': 51.5074,
        'lon': -0.1278,
      },
      {
        'city': 'Tokyo',
        'code': 'JP',
        'lat': 35.6895,
        'lon': 139.6917,
      },
      {
        'city': 'Sydney',
        'code': 'AU',
        'lat': -33.8688,
        'lon': 151.2093,
      },
    ];
    List<WeatherModel> _weather =
        await WeatherAPI.getWeathers(locationListWorld);
    if (repeat) {
      _weathers.addAll(_weather);
      repeat = false;
    }
    notifyListeners();
  }

  void addWeather(WeatherModel weather) {
    _weathers.add(weather);
    notifyListeners();
  }
}
