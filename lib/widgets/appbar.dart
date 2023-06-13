import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  final String title;
  final List<Widget> actionButtons;
  bool isChat = false;

  CustomAppBar(
      {super.key,
      required this.title,
      required this.actionButtons,
      this.isChat = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 80,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: !isChat
          ? Text(
              title.toUpperCase(),
              style: const TextStyle(
                  fontFamily: 'BNR', fontSize: 24, color: mainColor),
            )
          : LocaleText(
              title,
              upperCase: true,
              style: const TextStyle(
                  fontFamily: 'BNR', fontSize: 24, color: mainColor),
            ),
      actions: actionButtons,
    );
  }
}
