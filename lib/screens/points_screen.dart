import 'package:fishing_lab/models/place_model.dart';
import 'package:fishing_lab/provider/location_provider.dart';
import 'package:fishing_lab/screens/home_screen.dart';
import 'package:fishing_lab/screens/navigation_screen.dart';
import 'package:fishing_lab/services/admob_service.dart';
import 'package:fishing_lab/widgets/appbar.dart';
import 'package:fishing_lab/widgets/home_widgets/reminder.dart';
import 'package:fishing_lab/widgets/menu/custom_drawer.dart';
import 'package:fishing_lab/widgets/point_widgets/point_item.dart';
import 'package:fishing_lab/widgets/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

const int failureAttempts = 3;

class PointsScreen extends StatefulWidget {
  static const route = '/points';
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  TextEditingController? controller;
  // ignore: non_constant_identifier_names
  LocationProvider? location_controller;
  InterstitialAd? _interstitialAd;

  int _interstitialAttempt = 0;

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            setState(() {
              _interstitialAttempt = 0;
              _interstitialAd = ad;
            });
          },
          onAdFailedToLoad: (error) {
            _interstitialAttempt += 1;
            _interstitialAd = null;
            if (_interstitialAttempt >= failureAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _createInterstitialAd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    location_controller = Provider.of<LocationProvider>(context);
    location_controller!.clearSearchHistory();
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
    _interstitialAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    delete(String id) async {
      await showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('Are you sure you want to delete this point?'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close')),
                TextButton(
                  onPressed: () {
                    location_controller!.removePoint(id);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: CustomAppBar(
          title: 'Points',
          actionButtons: [
            Observer(builder: (context) {
              final mode = location_controller!.getTipMode;
              return IconButton(
                splashRadius: 25,
                onPressed: () {
                  location_controller!.changeTipsMode();
                },
                icon: mode
                    ? const Icon(
                        Icons.wb_incandescent_rounded,
                        size: 24,
                      )
                    : const Icon(
                        Icons.wb_incandescent_outlined,
                        size: 24,
                      ),
              );
            }),
            const SizedBox(
              width: 30,
            )
          ],
        ),
      ),
      body: Column(children: [
        Search(
          controller: controller!,
          callback: (String val) {
            location_controller!.search(val);
          },
        ),
        Observer(builder: (context) {
          final List<Place> places = location_controller!.getPlaces;
          List<Place> currentData = [];
          final mode = location_controller!.getTipMode;
          final List<Place> searchPlaces = location_controller!.searchPlaces;
          if (places.isEmpty) {
            return const SizedBox();
          }
          if (searchPlaces.isEmpty) {
            currentData = places;
          } else {
            currentData = searchPlaces;
          }

          return Expanded(
              child: Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                itemCount: currentData.length + 1,
                itemBuilder: (context, index) {
                  if (index == currentData.length) {
                    return const SizedBox(
                      height: 85,
                    );
                  }
                  final currentItem = currentData[index];
                  final path = location_controller!.getLocationImagePath(
                      lat: currentItem.location.lat,
                      lng: currentItem.location.lng,
                      width: 150,
                      height: 150,
                      zoom: 11);

                  return PointItem(
                      place: currentItem,
                      delete: () {
                        delete(currentItem.id);
                      },
                      path: path,
                      navigationCallback: () {
                        _showInterstitialAd();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigationScreen(
                                      destinationPlace: currentItem,
                                    )));
                      },
                      callback: () {
                        location_controller!
                            .changeTargetLocation(currentItem.location);
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.route);
                      });
                },
              ),
              mode
                  ? const Reminder(
                      text: 'Hold to start a trip ',
                      additional: 'DoubleTap to delete trip',
                    )
                  : const SizedBox(),
            ],
          ));
        })
      ]),
      drawer: const CustomDrawer(),
    );
  }
}
