import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback callback;
  final Color color;
  const AccountButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.callback,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: callback,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(text,
                      style: const TextStyle(
                        color: mainColor,
                        fontSize: 16,
                        fontFamily: 'MM',
                      )),
                ),
                Icon(
                  icon,
                  color: mainColor,
                  size: 26,
                )
              ],
            ),
          ),
        ));
  }
}
