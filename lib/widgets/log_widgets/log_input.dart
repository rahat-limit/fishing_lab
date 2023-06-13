import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LogInput extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool multilines;

  const LogInput(
      {super.key,
      required this.text,
      required this.controller,
      this.multilines = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        keyboardType: multilines ? TextInputType.multiline : TextInputType.text,
        minLines: 1,
        maxLines: multilines ? 5 : 1,
        style: const TextStyle(color: mainColor),
        decoration: InputDecoration(
          label: LocaleText(
            text,
            style: const TextStyle(fontSize: 19, color: mainColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(9)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: lightScaffoldColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(9)),
          ),
        ));
  }
}
