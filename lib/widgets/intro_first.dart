import 'package:fishing_lab/widgets/intro_button.dart';
import 'package:fishing_lab/widgets/intro_circle.dart';
import 'package:fishing_lab/widgets/intro_headline.dart';
import 'package:fishing_lab/widgets/intro_sub_text.dart';
import 'package:flutter/material.dart';

class IntroFirst extends StatelessWidget {
  final PageController controller;
  const IntroFirst({super.key, required this.controller});

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
            const IntroCircle(path: 'assets/images/intro_1.png'),
            const SizedBox(
              height: 10,
            ),
            const Headline(text: 'map and navigation'),
            const SizedBox(
              height: 20,
            ),
            const SubText(
              text: 'Look for new places and share with others',
            ),
            const SizedBox(
              height: 45,
            ),
            IntroButton(callback: () {
              controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            })
          ]),
    );
  }
}
