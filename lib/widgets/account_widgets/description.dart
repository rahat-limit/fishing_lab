import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class Description extends StatelessWidget {
  final String text;
  final IconData icon;
  const Description({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        LocaleText(
          text,
          style: const TextStyle(
              color: mainColor,
              fontSize: 24,
              fontFamily: 'BNR',
              letterSpacing: 1),
        ),
        Icon(
          icon,
          color: mainColor,
          size: 28,
        )
      ]),
    );
  }
}
