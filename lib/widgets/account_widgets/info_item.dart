import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class InfoItem extends StatelessWidget {
  final String text;
  final String placeholder;

  const InfoItem({super.key, required this.text, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
      decoration: BoxDecoration(
          color: tipBackgroundColor, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LocaleText(
            placeholder,
            style: const TextStyle(
                fontSize: 15, color: CupertinoColors.systemGreen),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
              child: Text(
            text,
            maxLines: 1,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'MM'),
          )),
        ],
      ),
    );
  }
}
