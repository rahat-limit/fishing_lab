import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_locales/flutter_locales.dart';

class ScreenHeadline extends StatelessWidget {
  final String text;
  const ScreenHeadline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return LocaleText(
      text,
      style: const TextStyle(fontSize: 21, fontFamily: 'MM', color: mainColor),
    );
  }
}
