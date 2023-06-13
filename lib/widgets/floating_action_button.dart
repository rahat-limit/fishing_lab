import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final String path;
  const ActionButton(
      {super.key,
      required this.text,
      required this.callback,
      required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(right: 10),
      child: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: borderColor,
        extendedPadding:
            const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        onPressed: callback,
        label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  path,
                ),
                height: 30,
                width: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              LocaleText(
                text,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MM'),
              )
            ]),
      ),
    );
  }
}
