import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
import 'package:tenkoyoho2/model/weather_model.dart';

class WeatherUserAPI {
  static Future<WeatherModel> getWeatherUser(
      double latitude, double longitude) async {
    String kOpenWeatherMapAPIKey = 'a5737cc1bcea45cb8d3ddc5771c1c47d';
    WeatherModel weather = WeatherModel();
    try {
      Response response = await Dio().get(
        'https://api.weatherbit.io/v2.0/forecast/daily?&&lat=$latitude&lon=$longitude&key=$kOpenWeatherMapAPIKey',
      );
      // print('weather ABC : ${response.data}');
      weather = WeatherModel.fromJson(response.data);
      // print('weather ABCD : ${weather}');
      // print('response: ${response.data}');
      // print('weather: ${weather.cityName}');
    } catch (e) {
      // if (kDebugMode) {
      // print('weather DATA SALAH $e');
      // }
      weather = WeatherModel(
          cityName: '',
          countryCode: '',
          data: [],
          lat: '',
          lon: '',
          stateCode: '',
          timezone: '');
    }
    return weather;
  }
}
