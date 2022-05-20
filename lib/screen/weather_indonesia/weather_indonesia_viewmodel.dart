import 'package:flutter/material.dart';
import 'package:tenkoyoho2/model/api/weather_api.dart';
// import 'package:tenkoyoho2/model/api/weather_user_api.dart';
// import 'package:tenkoyoho2/model/weather2_model.dart';

import 'package:tenkoyoho2/model/weather_model.dart';

enum WeatherIndoViewState {
  idle,
  loading,
  loaded,
  error,
}

class WeatherIndoViewModel with ChangeNotifier {
  final List<WeatherModel> _weathers = [];

  List<WeatherModel> get weathers => _weathers;
  WeatherIndoViewState _state = WeatherIndoViewState.idle;
  WeatherIndoViewState get state => _state;

  changeState(WeatherIndoViewState state) {
    _state = state;
    notifyListeners();
  }

  bool repeat = true;
  getAllWeathers() async {
    List<Map> locationListWorld = [
      {
        'city': 'Kediri',
        'code': 'ID',
        'lat': -7.4167,
        'lon': 112.4167,
      },
      {
        'city': 'Jakarta',
        'code': 'ID',
        'lat': -6.9167,
        'lon': 107.6167,
      },
      {
        'city': 'Surabaya',
        'code': 'ID',
        'lat': -7.25,
        'lon': 112.75,
      },
      {
        'city': 'Bali',
        'code': 'ID',
        'lat': -8.75,
        'lon': 115.2167,
      },
      {
        'city': 'Malang',
        'code': 'ID',
        'lat': -7.9167,
        'lon': 112.75,
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
