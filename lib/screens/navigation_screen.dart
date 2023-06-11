import 'package:fishing_lab/models/destination_model.dart';
import 'package:fishing_lab/models/location_model.dart';
import 'package:fishing_lab/models/place_model.dart';
import 'package:fishing_lab/provider/location_provider.dart';
import 'package:fishing_lab/services/map_service.dart';
import 'package:fishing_lab/widgets/appbar.dart';
import 'package:fishing_lab/widgets/home_widgets/reminder.dart';
import 'package:fishing_lab/widgets/menu/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatefulWidget {
  final Place destinationPlace;
  const NavigationScreen({super.key, required this.destinationPlace});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // ignore: non_constant_identifier_names
  LocationProvider? location_controller;
  GoogleMapController? _mapController;
  Location? location;
  Directions? info;
  CameraPosition? initCameraPosition;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    location_controller = Provider.of<LocationProvider>(context);
    if (mounted) {
      final LatLng originLL = LatLng(
          location_controller!.getPlaces[0].location.lat,
          location_controller!.getPlaces[0].location.lng);
      final LatLng destinationLL = LatLng(widget.destinationPlace.location.lat,
          widget.destinationPlace.location.lng);
      await MapService()
          .getDirections(origin: originLL, destination: destinationLL)
          .then((result) {
        if (result.runtimeType == Directions) {
          setState(() {
            info = result;
          });
        }
      });
    }
    trackLocation();
  }

  void trackLocation() async {
    if (mounted) {
      location = Location();
      await location!.getLocation();
      location!.onLocationChanged.listen((newLoc) {
        LocationModel locationModel = LocationModel(
            lat: newLoc.latitude!, lng: newLoc.longitude!, address: '');
        location_controller!.changeTargetLocation(locationModel);
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mapController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initCameraPosition = CameraPosition(
        target: LatLng(location_controller!.getPlaces[0].location.lat,
            location_controller!.getPlaces[0].location.lng),
        zoom: 12);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: const CustomAppBar(
          title: 'navigation',
          actionButtons: [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _mapController!.animateCamera(
              CameraUpdate.newCameraPosition(initCameraPosition!));
        },
        child: const Icon(Icons.center_focus_strong),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Observer(builder: (context) {
            return GoogleMap(
              onCameraMove: (position) {
                // setState(() {
                // initCameraPosition = CameraPosition(target: position.target);
                // });
              },
              initialCameraPosition: initCameraPosition!,
              myLocationButtonEnabled: false,
              onMapCreated: (controller) => _mapController = controller,
              markers: {
                Marker(
                    markerId: MarkerId(location_controller!.getPlaces[0].id),
                    position: LatLng(
                        location_controller!.getPlaces[0].location.lat,
                        location_controller!.getPlaces[0].location.lng),
                    infoWindow: const InfoWindow(title: 'Current Position'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueViolet)),
                Marker(
                    markerId: MarkerId(widget.destinationPlace.id),
                    position: LatLng(widget.destinationPlace.location.lat,
                        widget.destinationPlace.location.lng),
                    infoWindow:
                        InfoWindow(title: widget.destinationPlace.title),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen)),
              },
              polylines: {
                if (info != null)
                  Polyline(
                      polylineId: const PolylineId('overview'),
                      color: Colors.green,
                      width: 5,
                      points: info!.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList())
              },
            );
          }),
          info != null
              ? Reminder(
                  text: '${info!.totalDistance}, ${info!.totalDuration}',
                  position: false,
                )
              : const SizedBox()
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }
}
