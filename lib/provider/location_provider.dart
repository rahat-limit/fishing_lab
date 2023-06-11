import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fishing_lab/env.dart';
import 'package:fishing_lab/models/location_model.dart';
import 'package:fishing_lab/services/db/points_db.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fishing_lab/models/place_model.dart';
import 'package:fishing_lab/services/map_service.dart';
import 'package:mobx/mobx.dart';
part 'location_provider.g.dart';

// ignore: library_private_types_in_public_api
class LocationProvider = _LocationProviderBase with _$LocationProvider;

abstract class _LocationProviderBase with Store {
  final dio = Dio();
  @observable
  LocationModel? initLocation;
  @observable
  ObservableList<Place> places = ObservableList.of([]);
  @observable
  bool tipsMode = true;

  Marker? destinationPosition;

  @computed
  List<Place> get searchPlaces =>
      places.where((element) => element.priority == 1).toList();

  @computed
  List<Place> get getPlaces => places;

  @computed
  bool get getTipMode => tipsMode;

  @action
  changeTipsMode() {
    bool newState = !tipsMode;
    tipsMode = newState;
  }

  @action
  getLocationModel({bool init = false}) async {
    final locationData = await MapService().defineCurrentLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    final response = await dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${Env.googleApiKey}');
    if (response.statusCode == 200 && initLocation == null) {
      final address = response.data['results'][0]['formatted_address'];
      final location = LocationModel(lat: lat, lng: lng, address: address);
      final place = Place(title: 'Home', location: location);
      places.insert(0, place);
      initLocation = location;
      return location;
    } else {
      return;
    }
  }

  getLocationImagePath(
      {required double lat,
      required double lng,
      int width = 600,
      int height = 350,
      int zoom = 17}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center$lat,$lng=&zoom=$zoom&size=${width}x$height&maptype=roadmap&markers=color:blue%7Clabel:P%7C$lat,$lng&key=${Env.googleApiKey}';
  }

  @action
  addToPlaces({
    required String title,
    required double lat,
    required double lng,
  }) async {
    final response = await dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${Env.googleApiKey}');
    if (response.statusCode == 200) {
      final address = response.data['results'][0]['formatted_address'];
      final location = LocationModel(lat: lat, lng: lng, address: address);
      final place = Place(title: title, location: location);
      // Add to LocalDB, condition to avoid adding Home Point
      if (places.isNotEmpty) {
        await PointsLocalStorage().insert(place: place);
      }
      places.add(place);
    }
  }

  @action
  changeTargetLocation(LocationModel location) {
    initLocation = location;
  }

  @action
  search(String key) {
    for (var element in places) {
      var newElem = element;
      newElem.priority = 0;
      if (element.title.toLowerCase().contains(key.toLowerCase()) ||
          element.location.address.toLowerCase().contains(key.toLowerCase())) {
        newElem.priority = 1;
      }
      int index = places.indexOf(element);
      places.remove(element);
      places.insert(index, newElem);
    }
  }

  @action
  clearSearchHistory() {
    for (var element in places) {
      var newElem = element;
      newElem.priority = 0;
      element = newElem;
    }
  }

  @action
  getFromLocalDB() async {
    List<Place> data = await PointsLocalStorage().getData();
    places.addAll(data);
  }

  @action
  addToLocalDb(Place place) async {
    await PointsLocalStorage().insert(place: place);
  }

  // places length cannot be less than 1, otherwise cause an error
  @action
  removeFromLocalDB(String id) async {
    await PointsLocalStorage().deleteRow(id);
  }

  @action
  removePoint(String id) async {
    await PointsLocalStorage().deleteRow(id);
    places.removeWhere((element) => element.id == id);
  }
}
