import 'package:fishing_lab/screens/auth_screen.dart';
import 'package:fishing_lab/widgets/intro_button.dart';
import 'package:fishing_lab/widgets/intro_circle.dart';
import 'package:fishing_lab/widgets/intro_headline.dart';
import 'package:fishing_lab/widgets/intro_sub_text.dart';
import 'package:flutter/material.dart';

class IntroThird extends StatelessWidget {
  const IntroThird({super.key});

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
            const IntroCircle(
              path: 'assets/images/intro_3.png',
              padding: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            const Headline(text: 'catch_log'),
            const SizedBox(
              height: 20,
            ),
            const SubText(
              text: 'catch_log_description',
            ),
            const SizedBox(
              height: 45,
            ),
            IntroButton(
              text: 'Start',
              callback: () {
                Navigator.pushReplacementNamed(context, AuthScreen.route);
              },
            )
          ]),
    );
  }
}
