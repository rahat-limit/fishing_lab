import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final List<Widget> actionButtons;
  const CustomAppBar(
      {super.key, required this.title, required this.actionButtons});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 80,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style:
            const TextStyle(fontFamily: 'BNR', fontSize: 30, color: mainColor),
      ),
      actions: actionButtons,
    );
  }
}
