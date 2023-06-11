import 'package:fishing_lab/constants/colors.dart';
import 'package:fishing_lab/provider/splash_provider.dart';
import 'package:fishing_lab/screen_divider.dart';
import 'package:fishing_lab/screens/account_screen.dart';
import 'package:fishing_lab/screens/auth_screen.dart';
import 'package:fishing_lab/screens/chat_screen.dart';
import 'package:fishing_lab/screens/forgot_screen.dart';
import 'package:fishing_lab/screens/home_screen.dart';
import 'package:fishing_lab/screens/log_screen.dart';
import 'package:fishing_lab/screens/new_log_screen.dart';
import 'package:fishing_lab/screens/points_screen.dart';
import 'package:fishing_lab/screens/splash_screen.dart';
import 'package:fishing_lab/screens/tips_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  // ignore: non_constant_identifier_names
  SplashProvider? splash_controller;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    splash_controller = Provider.of<SplashProvider>(context);
    splash_controller!.defineChecked();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [const ScreenDivider(), const SplashScreen()];

    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: scaffoldColor,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          )),
      debugShowCheckedModeBanner: false,
      home: Observer(
        builder: (context) {
          final index = splash_controller!.checked;
          return screens[index];
        },
      ),
      routes: {
        HomeScreen.route: (context) => const HomeScreen(),
        ChatScreen.route: (context) => const ChatScreen(),
        LogScreen.route: (context) => const LogScreen(),
        SplashScreen.route: (context) => const SplashScreen(),
        TipsScreen.route: (context) => const TipsScreen(),
        AuthScreen.route: (context) => const AuthScreen(),
        ForgotScreen.route: (context) => const ForgotScreen(),
        AccountScreen.route: (context) => const AccountScreen(),
        PointsScreen.route: (context) => const PointsScreen(),
        NewLogScreen.route: (context) => const NewLogScreen(),
      },
    );
  }
}
