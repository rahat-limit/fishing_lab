import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LogDetail extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback callback;
  const LogDetail(
      {super.key,
      required this.text,
      required this.icon,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          side: const BorderSide(width: 1.0, color: mainColor),
        ),
        onPressed: callback,
        icon: Icon(
          icon,
          color: mainColor,
          size: 24,
        ),
        label: LocaleText(
          text,
          style: const TextStyle(color: mainColor, fontSize: 16),
        ));
  }
}
