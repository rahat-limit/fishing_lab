import 'package:fishing_lab/models/place_model.dart';
import 'package:fishing_lab/provider/location_provider.dart';
import 'package:fishing_lab/screens/new_place_screen.dart';
import 'package:fishing_lab/services/admob_service.dart';
import 'package:fishing_lab/widgets/appbar.dart';
import 'package:fishing_lab/widgets/home_widgets/reminder.dart';
import 'package:fishing_lab/widgets/menu/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: non_constant_identifier_names
  LocationProvider? location_controller;
  bool staicMode = true;
  BannerAd? _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd!.load();
  }

  @override
  void initState() {
    super.initState();
    _createBottomBannerAd();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    location_controller = Provider.of<LocationProvider>(context);
    when((p0) => location_controller!.getPlaces.length == 1, () {
      location_controller!.getFromLocalDB();
    });
    location_controller!.getLocationModel(init: true);
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: CustomAppBar(
          title: 'map and navigation',
          actionButtons: const [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Observer(builder: (context) {
              final initLocation = location_controller!.initLocation;
              Set<Marker> marker = {};
              if (location_controller!.places.isNotEmpty) {
                marker =
                    List.generate(location_controller!.places.length, (index) {
                  Place item = location_controller!.places[index];

                  return Marker(
                      markerId: MarkerId(item.id),
                      position: LatLng(item.location.lat, item.location.lng),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen));
                }).toSet();
              }

              return Stack(
                alignment: Alignment.center,
                children: [
                  location_controller!.places.isEmpty && initLocation == null
                      ? const SizedBox()
                      : GoogleMap(
                          myLocationButtonEnabled: false,
                          onLongPress: (position) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewPlaceScreen(
                                          lat: position.latitude,
                                          lng: position.longitude,
                                        )));
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(initLocation!.lat, initLocation.lng),
                            zoom: 12,
                          ),
                          markers: marker),
                  const Reminder(
                    text: 'Hold to set a point',
                    padding: 80,
                  ),
                  _isBottomBannerAdLoaded
                      ? Positioned(
                          bottom: 20,
                          child: SizedBox(
                            // margin: const EdgeInsets.only(bottom: 20),
                            height: _bottomBannerAd!.size.height.toDouble(),
                            width: _bottomBannerAd!.size.width.toDouble(),
                            child: AdWidget(ad: _bottomBannerAd!),
                          ),
                        )
                      : const SizedBox()
                ],
              );
            }),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }
}
