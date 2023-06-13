import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

// ignore: must_be_immutable
class IntroButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  bool isLang = false;
  IntroButton(
      {super.key,
      this.text = 'Next',
      required this.callback,
      this.isLang = false});

  @override
  Widget build(BuildContext context) {
    if (isLang) {
      return Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size.fromWidth(250),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: mainColor),
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              onPressed: () async {
                Locales.change(context, 'ru');
                await Future.delayed(const Duration(milliseconds: 500));
                callback();
              },
              child: const Row(
                children: [
                  Image(
                    image: AssetImage('assets/images/russia.png'),
                    width: 60,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'RUSSIAN',
                    style: TextStyle(
                        fontFamily: 'MR',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  )
                ],
              )),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size.fromWidth(250),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: mainColor),
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              onPressed: () async {
                Locales.change(context, 'en');
                await Future.delayed(const Duration(milliseconds: 500));
                callback();
              },
              child: const Row(
                children: [
                  Image(
                    image: AssetImage('assets/images/united-kingdom.png'),
                    width: 60,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'ENGLISH',
                    style: TextStyle(
                        fontFamily: 'MR',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  )
                ],
              )),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size.fromWidth(250),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: mainColor),
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              onPressed: () async {
                Locales.change(context, 'kk');
                await Future.delayed(const Duration(milliseconds: 500));
                callback();
              },
              child: const Row(
                children: [
                  Image(
                    image: AssetImage('assets/images/kazakhstan.png'),
                    width: 60,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'KAZAKH',
                    style: TextStyle(
                        fontFamily: 'MR',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  )
                ],
              )),
        ],
      );
    } else {
      return ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: mainColor),
                borderRadius: BorderRadius.circular(21)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45)),
        child: LocaleText(
          text,
          style:
              const TextStyle(fontFamily: 'MR', fontSize: 21, color: mainColor),
        ),
      );
    }
  }
}
