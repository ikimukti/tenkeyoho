import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tenkoyoho2/model/weather_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;
  DatabaseHelper._internal() {
    _databaseHelper = this;
  }
  factory DatabaseHelper() => _databaseHelper ??= DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  final String _tableName = 'weather';

  Future<Database> _initDatabase() async {
    var db = openDatabase(
      join(await getDatabasesPath(), 'weather.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, wdata TEXT, city_name TEXT, lon TEXT, timezone TEXT, lat TEXT, country_code TEXT, state_code TEXT)',
        );
      },
    );
    return db;
  }

  Future<void> insertWeather(WeatherModel weather) async {
    final Database db = await database;
    await db.insert(
      _tableName,
      weather.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<WeatherModel>> getWeathersFromDB() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return maps
        .map(
          (e) => WeatherModel.fromMap(e),
        )
        .toList();
  }

  Future<WeatherModel> getWeathersFromDBbyId(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps
        .map(
          (e) => WeatherModel.fromMap(e),
        )
        .first;
  }

  Future<WeatherModel> getWeathersFromDBbyCityNameCountryCodeStateCode(
    String cityName,
    String countryCode,
    String stateCode,
  ) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'city_name = ? AND country_code = ? AND state_code = ?',
      whereArgs: [cityName, countryCode, stateCode],
    );
    return maps
        .map(
          (e) => WeatherModel.fromMap(e),
        )
        .first;
  }

  Future<void> updateWeatherDBbyCityNameCountryCodeStateCode(
    String cityName,
    String countryCode,
    String stateCode,
    WeatherModel weather,
  ) async {
    final Database db = await database;
    await db.update(
      _tableName,
      weather.toMap(),
      where: 'city_name = ? AND country_code = ? AND state_code = ?',
      whereArgs: [cityName, countryCode, stateCode],
    );
  }

  Future<void> deleteWeatherDBbyCityNameCountryCodeStateCode(
    String cityName,
    String countryCode,
    String stateCode,
  ) async {
    final Database db = await database;
    await db.delete(
      _tableName,
      where: 'city_name = ? AND country_code = ? AND state_code = ?',
      whereArgs: [cityName, countryCode, stateCode],
    );
  }
}
