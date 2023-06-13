import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class AuthInput extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final void Function(String) callback;
  final bool isPassword;
  const AuthInput(
      {super.key,
      required this.controller,
      required this.text,
      required this.callback,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        callback(value ?? '');
        return null;
      },
      style: const TextStyle(color: mainColor),
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: lightScaffoldColor, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        label: LocaleText(
          text,
          style: const TextStyle(fontSize: 19, color: lightMainColor),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 19, horizontal: 15),
      ),
    );
  }
}
