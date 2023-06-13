import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class Headline extends StatelessWidget {
  final String text;
  const Headline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return LocaleText(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontFamily: 'BNR', fontSize: 28, color: mainColor),
    );
  }
}
