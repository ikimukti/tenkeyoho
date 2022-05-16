import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tenkoyoho2/model/weather_model.dart';

class WeatherAPI {
  static Future<List<WeatherModel>> getWeathers(List<Map> locationList) async {
    String kOpenWeatherMapAPIKey = '3e9b6ba197ed4078b95189c88f037608';
    List<WeatherModel> weathers = [];
    for (var i = 0; i < locationList.length; i++) {
      Map location = locationList[i];
      String city = location['city'];
      String code = location['code'];
      // double lat = location['lat'];
      // double lon = location['lon'];
      try {
        Response response =
            await Future.delayed(const Duration(seconds: 1), () async {
          return await Dio().get(
            'https://api.weatherbit.io/v2.0/forecast/daily?city=$city,$code&key=$kOpenWeatherMapAPIKey',
          );
        });
        // print('response: ${response.data}');
        WeatherModel weather = WeatherModel.fromJson(response.data);
        // print('weather: ${weather.cityName}');
        weathers.add(weather);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        weathers.add(WeatherModel(
            cityName: '',
            countryCode: '',
            data: [],
            lat: '',
            lon: '',
            stateCode: '',
            timezone: ''));
      }
    }
    return weathers;
  }
}
