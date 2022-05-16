import 'dart:convert';

class WeatherLocation {
  final String city;
  final String dateTime;
  final String temperature;
  final String weatherType;
  final String iconUrl;
  final int windSpeed;
  final int rain;
  final int humidity;

  WeatherLocation({
    required this.city,
    required this.dateTime,
    required this.temperature,
    required this.weatherType,
    required this.iconUrl,
    required this.windSpeed,
    required this.rain,
    required this.humidity,
  });

  WeatherLocation copyWith({
    String? city,
    String? dateTime,
    String? temperature,
    String? weatherType,
    String? iconUrl,
    int? windSpeed,
    int? rain,
    int? humidity,
  }) {
    return WeatherLocation(
      city: city ?? this.city,
      dateTime: dateTime ?? this.dateTime,
      temperature: temperature ?? this.temperature,
      weatherType: weatherType ?? this.weatherType,
      iconUrl: iconUrl ?? this.iconUrl,
      windSpeed: windSpeed ?? this.windSpeed,
      rain: rain ?? this.rain,
      humidity: humidity ?? this.humidity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'dateTime': dateTime,
      'temperature': temperature,
      'weatherType': weatherType,
      'iconUrl': iconUrl,
      'windSpeed': windSpeed,
      'rain': rain,
      'humidity': humidity,
    };
  }

  factory WeatherLocation.fromMap(Map<String, dynamic> map) {
    return WeatherLocation(
      city: map['city'] ?? '',
      dateTime: map['dateTime'] ?? '',
      temperature: map['temperature'] ?? '',
      weatherType: map['weatherType'] ?? '',
      iconUrl: map['iconUrl'] ?? '',
      windSpeed: map['windSpeed']?.toInt() ?? 0,
      rain: map['rain']?.toInt() ?? 0,
      humidity: map['humidity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherLocation.fromJson(String source) =>
      WeatherLocation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WeatherLocation(city: $city, dateTime: $dateTime, temperature: $temperature, weatherType: $weatherType, iconUrl: $iconUrl, windSpeed: $windSpeed, rain: $rain, humidity: $humidity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherLocation &&
        other.city == city &&
        other.dateTime == dateTime &&
        other.temperature == temperature &&
        other.weatherType == weatherType &&
        other.iconUrl == iconUrl &&
        other.windSpeed == windSpeed &&
        other.rain == rain &&
        other.humidity == humidity;
  }

  @override
  int get hashCode {
    return city.hashCode ^
        dateTime.hashCode ^
        temperature.hashCode ^
        weatherType.hashCode ^
        iconUrl.hashCode ^
        windSpeed.hashCode ^
        rain.hashCode ^
        humidity.hashCode;
  }
}

final List<WeatherLocation> weatherLocations = [
  WeatherLocation(
    city: 'London',
    dateTime: '2020-01-01T12:00:00',
    temperature: '10°C',
    weatherType: 'Sunny',
    iconUrl: 'assets/rain.svg',
    windSpeed: 10,
    rain: 0,
    humidity: 10,
  ),
  WeatherLocation(
    city: 'Moscow',
    dateTime: '2020-01-01T12:00:00',
    temperature: '10°C',
    weatherType: 'Night',
    iconUrl: 'assets/rain.svg',
    windSpeed: 10,
    rain: 0,
    humidity: 10,
  ),
  WeatherLocation(
    city: 'Paris',
    dateTime: '2020-01-01T12:00:00',
    temperature: '10°C',
    weatherType: 'Rainy',
    iconUrl: 'assets/rain.svg',
    windSpeed: 10,
    rain: 0,
    humidity: 10,
  ),
  WeatherLocation(
    city: 'Berlin',
    dateTime: '2020-01-01T12:00:00',
    temperature: '10°C',
    weatherType: 'Cloudy',
    iconUrl: 'assets/rain.svg',
    windSpeed: 10,
    rain: 0,
    humidity: 10,
  ),
  WeatherLocation(
    city: 'Madrid',
    dateTime: '2020-01-01T12:00:00',
    temperature: '10°C',
    weatherType: 'Sunny',
    iconUrl: 'assets/sun.svg',
    windSpeed: 10,
    rain: 0,
    humidity: 10,
  ),
  WeatherLocation(
    city: 'Rome',
    dateTime: '2020-01-01T12:00:00',
    temperature: '10°C',
    weatherType: 'Snowy',
    iconUrl: 'assets/rain.svg',
    windSpeed: 10,
    rain: 0,
    humidity: 10,
  ),
];
