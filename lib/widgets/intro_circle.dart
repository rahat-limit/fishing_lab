import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';

class IntroCircle extends StatelessWidget {
  final String path;
  final double padding;
  const IntroCircle({super.key, required this.path, this.padding = 25});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 330, maxHeight: 330),
        width: MediaQuery.of(context).size.width - 80,
        height: MediaQuery.of(context).size.width - 80,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(300),
            border: Border.all(width: 8, color: borderColor)),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 250, maxHeight: 250),
            width: MediaQuery.of(context).size.width - 150,
            height: MediaQuery.of(context).size.width - 150,
            decoration: BoxDecoration(
                color: lightScaffoldColor,
                borderRadius: BorderRadius.circular(300),
                border: Border.all(
                  width: 15,
                  color: borderColor,
                ),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 20, spreadRadius: 10, color: Colors.black26)
                ]),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Image(
                image: AssetImage(
                  path,
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ));
  }
}
