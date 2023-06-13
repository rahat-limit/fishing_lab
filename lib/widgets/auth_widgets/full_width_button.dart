import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class FullWithButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const FullWithButton({
    super.key,
    required this.text,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  backgroundColor: tipBackgroundColor),
              onPressed: callback,
              child: LocaleText(
                text,
                style: const TextStyle(
                    fontSize: 19,
                    fontFamily: 'MontserratMedium',
                    fontWeight: FontWeight.w500),
              )),
        )
      ],
    );
  }
}
