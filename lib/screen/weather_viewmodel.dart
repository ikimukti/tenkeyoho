import 'package:flutter/material.dart';
import 'package:tenkoyoho2/model/api/weather_api.dart';
// import 'package:tenkoyoho2/model/api/weather_user_api.dart';

import 'package:tenkoyoho2/model/weather_model.dart';

enum WeatherViewState {
  idle,
  loading,
  loaded,
  error,
}

class WeatherViewModel with ChangeNotifier {
  final List<WeatherModel> _weathers = [];
  WeatherViewState _state = WeatherViewState.idle;
  WeatherViewState get state => _state;

  changeState(WeatherViewState state) {
    _state = state;
    notifyListeners();
  }

  List<WeatherModel> get weathers => _weathers;

  bool repeat = true;
  getAllWeathers() async {
    List<Map> locationList = [
      {
        'city': 'Jakarta',
        'code': 'ID',
        'lat': -6.1751,
        'lon': 106.8455,
      },
      {
        'city': 'Kediri',
        'code': 'ID',
        'lat': -7.848,
        'lon': 112.4304,
      },
      {
        'city': 'Bandung',
        'code': 'ID',
        'lat': -6.9175,
        'lon': 107.6191,
      },
    ];
    List<WeatherModel> _weather2 = await WeatherAPI.getWeathers(locationList);
    if (repeat) {
      _weathers.addAll(_weather2);
      repeat = false;
    }
    notifyListeners();
  }

  void addWeather(WeatherModel weather) {
    _weathers.add(weather);
    notifyListeners();
  }
}
