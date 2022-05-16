import 'package:flutter/material.dart';
import 'package:tenkoyoho2/model/api/weather_user_api.dart';
import 'package:tenkoyoho2/model/weather_model.dart';

class WeatherUserViewModel with ChangeNotifier {
  final WeatherModel _weathers = WeatherModel(
    cityName: '',
    countryCode: '',
    data: [],
    lat: '',
    lon: '',
    stateCode: '',
    timezone: '',
  );
  WeatherModel get weathers => _weathers;
  bool repeat = true;

  getWeathers(double latitude, double longitude) async {
    // print('latitude XXXXX: $latitude');
    // print('longitude XXXXX: $longitude');
    WeatherModel _weather =
        await WeatherUserAPI.getWeatherUser(latitude, longitude);
    // if (repeat) {
    // print('weather OOOO: ${_weather.cityName}');
    _weathers.cityName = _weather.cityName;
    _weathers.countryCode = _weather.countryCode;
    _weathers.data = _weather.data;
    _weathers.lat = _weather.lat;
    _weathers.lon = _weather.lon;
    _weathers.stateCode = _weather.stateCode;
    _weathers.timezone = _weather.timezone;
    repeat = false;
    // }
    notifyListeners();
  }

  void addWeather(WeatherModel weather) {
    _weathers.cityName = weather.cityName;
    _weathers.countryCode = weather.countryCode;
    _weathers.data = weather.data;
    _weathers.lat = weather.lat;
    _weathers.lon = weather.lon;
    _weathers.stateCode = weather.stateCode;
    _weathers.timezone = weather.timezone;
    notifyListeners();
  }
}
