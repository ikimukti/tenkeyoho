import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenkoyoho2/model/user_location_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tenkoyoho2/screen/weather_user_viewmodel.dart';

class LocationService {
  final StreamController<UserLocation> _locationStreamController =
      StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationStreamController.stream;
  String address = 'search';
  Placemark placemark = Placemark();

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (kDebugMode) {
      print(placemarks);
    }
    Placemark place = placemarks[0];
    placemark = place;
    address =
        '${place.name}, ${place.street},${place.isoCountryCode},${place.country}, ${place.postalCode}, ${place.administrativeArea}, ${place.subAdministrativeArea}, ${place.locality}, ${place.subLocality}, ${place.subThoroughfare}, ${place.thoroughfare}';
    placemark = place;
  }

  LocationService() {
    _getGeoLocationPosition().then(
      (position) {
        getAddressFromLatLong(position).then(
          (value) => {
            _locationStreamController.add(
              UserLocation(
                latitude: position.latitude,
                longitude: position.longitude,
                address: address,
                accuracy: position.accuracy,
                altitude: position.altitude,
                speed: position.speed,
                speedAccuracy: position.speedAccuracy,
                heading: position.heading,
                timestamp: position.timestamp,
                name: placemark.name,
                street: placemark.street,
                isoCountryCode: placemark.isoCountryCode,
                country: placemark.country,
                postalCode: placemark.postalCode,
                administrativeArea: placemark.administrativeArea,
                subAdministrativeArea: placemark.subAdministrativeArea,
                locality: placemark.locality,
                subLocality: placemark.subLocality,
                thoroughfare: placemark.thoroughfare,
                subThoroughfare: placemark.subThoroughfare,
              ),
            ),
          },
        );
      },
    );
  }

  void dispose() {
    _locationStreamController.close();
  }
}
