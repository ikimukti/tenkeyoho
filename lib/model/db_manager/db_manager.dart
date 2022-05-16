import 'package:flutter/material.dart';
import 'package:tenkoyoho2/helper/db/database_helper.dart';
import 'package:tenkoyoho2/model/weather_model.dart';

class DbManager extends ChangeNotifier {
  List<WeatherModel> _weathers = [];
  late DatabaseHelper _databaseHelper;

  List<WeatherModel> get weathers => _weathers;

  DbManager() {
    _databaseHelper = DatabaseHelper();
    _getAllWeathers();
  }

  void _getAllWeathers() async {
    _weathers = await _databaseHelper.getWeathersFromDB();
    notifyListeners();
  }

  Future<void> insertWeather(WeatherModel weather) async {
    await _databaseHelper.insertWeather(weather);
    _getAllWeathers();
    notifyListeners();
  }

  Future<void> getWeathersFromDBbyCityNameCountryCodeStateCode(
      String cityName, String countryCode, String stateCode) async {
    _weathers =
        (await _databaseHelper.getWeathersFromDBbyCityNameCountryCodeStateCode(
            cityName, countryCode, stateCode)) as List<WeatherModel>;
    notifyListeners();
  }

  Future<void> updateWeatherDBbyCityNameCountryCodeStateCode(String cityName,
      String countryCode, String stateCode, WeatherModel weather) async {
    await _databaseHelper.updateWeatherDBbyCityNameCountryCodeStateCode(
        cityName, countryCode, stateCode, weather);
    _getAllWeathers();
    notifyListeners();
  }

  void deleteWeatherDBbyCityNameCountryCodeStateCode(
      String cityName, String countryCode, String stateCode) async {
    await _databaseHelper.deleteWeatherDBbyCityNameCountryCodeStateCode(
        cityName, countryCode, stateCode);
    _getAllWeathers();
    notifyListeners();
  }
}
