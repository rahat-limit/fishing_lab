import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class VerifiedEmail extends StatelessWidget {
  const VerifiedEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.greenAccent),
          borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: LocaleText('Your Email is Verified!',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 16,
                    fontFamily: 'MM',
                  )),
            ),
            Icon(
              Icons.verified,
              color: mainColor,
              size: 26,
            )
          ]),
    );
  }
}
