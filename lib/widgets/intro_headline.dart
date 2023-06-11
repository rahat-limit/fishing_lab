import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  final String text;
  const Headline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontFamily: 'BNR', fontSize: 40, color: mainColor),
    );
  }
}
