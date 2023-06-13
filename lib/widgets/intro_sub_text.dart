import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class SubText extends StatelessWidget {
  final String text;
  const SubText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: LocaleText(
        text,
        textAlign: TextAlign.center,
        style:
            const TextStyle(fontFamily: 'MR', fontSize: 20, color: mainColor),
      ),
    );
  }
}
