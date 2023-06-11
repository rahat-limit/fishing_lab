// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:fishing_lab/env.dart';
import 'package:fishing_lab/models/destination_model.dart';
// ignore: depend_on_referenced_packages
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

class MapService {
  static const String baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';
  final Dio dio = Dio();
  Future defineCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await dio.get(
      baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': Env.googleApiKey,
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      if ((response.data['routes'] as List).isNotEmpty) {
        return Directions.fromMap(response.data);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
