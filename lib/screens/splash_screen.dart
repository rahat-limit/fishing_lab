import 'package:fishing_lab/constants/colors.dart';
import 'package:fishing_lab/widgets/intro_first.dart';
import 'package:fishing_lab/widgets/intro_second.dart';
import 'package:fishing_lab/widgets/intro_third.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);
  @override
  Widget build(BuildContext context) {
    final List<Widget> tabBarContentPages = [
      IntroFirst(
        controller: controller,
      ),
      IntroSecond(
        controller: controller,
      ),
      const IntroThird()
    ];
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(children: [
          SmoothPageIndicator(
            controller: controller,
            count: tabBarContentPages.length,
            effect: const ExpandingDotsEffect(
                dotWidth: 21,
                dotHeight: 21,
                // ignore: use_full_hex_values_for_flutter_colors
                activeDotColor: tipBackgroundColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: tabBarContentPages.length,
              itemBuilder: (context, index) {
                return tabBarContentPages[index % tabBarContentPages.length];
              },
            ),
          ),
        ]),
      )),
    );
  }
}
