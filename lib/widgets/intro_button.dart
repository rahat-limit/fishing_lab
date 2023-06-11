import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';

class IntroButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const IntroButton({super.key, this.text = 'Next', required this.callback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: mainColor),
              borderRadius: BorderRadius.circular(21)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45)),
      child: Text(
        text,
        style:
            const TextStyle(fontFamily: 'MR', fontSize: 21, color: mainColor),
      ),
    );
  }
}
