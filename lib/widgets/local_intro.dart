import 'package:fishing_lab/widgets/intro_button.dart';
import 'package:fishing_lab/widgets/intro_circle.dart';
import 'package:fishing_lab/widgets/intro_headline.dart';
import 'package:flutter/material.dart';

class LocalIntro extends StatelessWidget {
  final PageController controller;
  const LocalIntro({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            const IntroCircle(path: 'assets/images/language.png'),
            const SizedBox(
              height: 10,
            ),
            const Headline(text: 'Choose Language'),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            IntroButton(
              callback: () {
                controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              isLang: true,
            ),
          ]),
    );
  }
}
