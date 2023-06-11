import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';

class Reminder extends StatelessWidget {
  final String text;
  final bool position;
  final String additional;
  final double padding;
  const Reminder(
      {super.key,
      required this.text,
      this.position = true,
      this.additional = '',
      this.padding = 45});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: position ? padding : null,
        top: position ? null : 20,
        child: Column(
          children: [
            additional.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                        color: lightScaffoldColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(children: [
                      const Image(
                        image: AssetImage('assets/images/lamp.png'),
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        additional,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DNM',
                            color: mainColor,
                            letterSpacing: -0.5),
                      )
                    ]),
                  )
                : const SizedBox(),
            additional.isEmpty
                ? const SizedBox()
                : const SizedBox(
                    height: 10,
                  ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
              decoration: BoxDecoration(
                  color: lightScaffoldColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                const Image(
                  image: AssetImage('assets/images/lamp.png'),
                  width: 25,
                  height: 25,
                ),
                const SizedBox(width: 15),
                Text(
                  text,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DNM',
                      color: mainColor,
                      letterSpacing: -0.5),
                )
              ]),
            ),
          ],
        ));
  }
}
