import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class ScreenHeadline extends StatelessWidget {
  final String text;
  const ScreenHeadline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 21, fontFamily: 'MM', color: mainColor),
    );
  }
}
