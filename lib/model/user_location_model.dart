class UserLocation {
  final double latitude;
  final double longitude;
  final String? address;
  final double accuracy;
  final double altitude;
  final double speed;
  final double speedAccuracy;
  final double heading;
  final DateTime? timestamp;
  final String? name;
  final String? street;
  final String? isoCountryCode;
  final String? country;
  final String? postalCode;
  final String? administrativeArea;
  final String? subAdministrativeArea;
  final String? locality;
  final String? subLocality;
  final String? thoroughfare;
  final String? subThoroughfare;

  UserLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.accuracy,
    required this.altitude,
    required this.speed,
    required this.speedAccuracy,
    required this.heading,
    required this.timestamp,
    required this.name,
    required this.street,
    required this.isoCountryCode,
    required this.country,
    required this.postalCode,
    required this.administrativeArea,
    required this.subAdministrativeArea,
    required this.locality,
    required this.subLocality,
    required this.subThoroughfare,
    required this.thoroughfare,
  });
}
