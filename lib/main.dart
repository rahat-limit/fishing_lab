import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:fishing_lab/provider/auth_provider.dart';
import 'package:fishing_lab/provider/location_provider.dart';
import 'package:fishing_lab/provider/log_provider.dart';
import 'package:fishing_lab/provider/splash_provider.dart';
import 'package:fishing_lab/provider/tip_provider.dart';
import 'package:fishing_lab/screen_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppTrackingTransparency.requestTrackingAuthorization();
  await MobileAds.instance.initialize();
  await Locales.init(['en', 'ru', 'kk']);
  runApp(MultiProvider(providers: [
    Provider<SplashProvider>(
      create: (_) => SplashProvider(),
    ),
    Provider<AuthProvider>(
      create: (_) => AuthProvider(),
    ),
    Provider<LocationProvider>(
      create: (_) => LocationProvider(),
    ),
    Provider<LogProvider>(
      create: (_) => LogProvider(),
    ),
    Provider<TipProvider>(
      create: (_) => TipProvider(),
    ),
  ], child: const ScreenRouter()));
}
