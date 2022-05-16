import 'package:flutter/material.dart';
import 'package:tenkoyoho2/model/api/weather_api.dart';
import 'package:tenkoyoho2/model/api/weather_user_api.dart';
// import 'package:tenkoyoho2/model/api/weather_user_api.dart';
// import 'package:tenkoyoho2/model/weather2_model.dart';

import 'package:tenkoyoho2/model/weather_model.dart';

class WeatherDetailsViewModel with ChangeNotifier {
  final WeatherModel _weather = WeatherModel();

  WeatherModel get weather => _weather;

  bool repeat = true;
  getAllWeathers() async {
    WeatherModel _weathers =
        await WeatherUserAPI.getWeatherUser(38.123, -78.543);
    if (repeat) {
      weather.data = _weathers.data;
      weather.cityName = _weathers.cityName;
      weather.countryCode = _weathers.countryCode;
      weather.lat = _weathers.lat;
      weather.lon = _weathers.lon;
      weather.stateCode = _weathers.stateCode;
      weather.timezone = _weathers.timezone;
      repeat = false;
    }
    notifyListeners();
  }

  void addWeather(WeatherModel weathers) {
    weather.data = weathers.data;
    weather.cityName = weathers.cityName;
    weather.countryCode = weathers.countryCode;
    weather.lat = weathers.lat;
    weather.lon = weathers.lon;
    weather.stateCode = weathers.stateCode;
    weather.timezone = weathers.timezone;
    notifyListeners();
  }
}
