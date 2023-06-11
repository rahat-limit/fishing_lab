import 'package:fishing_lab/constants/colors.dart';
import 'package:fishing_lab/models/tip_model.dart';
import 'package:flutter/cupertino.dart';

class TipInfo extends StatelessWidget {
  final TipModel tip;
  const TipInfo({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: 60,
          height: 10,
          decoration: BoxDecoration(
              color: mainColor, borderRadius: BorderRadius.circular(15)),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 8, bottom: 30),
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              CupertinoIcons.exclamationmark_circle,
                              size: 30,
                              color: CupertinoColors.systemRed,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'REMEMBER',
                              style: TextStyle(
                                  fontFamily: 'BNR',
                                  fontSize: 32,
                                  color: mainColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                                child: Text(
                              tip.shortText,
                              style: const TextStyle(
                                  color: lightMainColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'MM'),
                            ))
                          ],
                        ),
                      ],
                    )),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: tipBackgroundColor,
                      ),
                      child: Center(
                          child: Image(
                        image: AssetImage(tip.path),
                        fit: BoxFit.contain,
                        width: 60,
                        height: 60,
                      )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      tip.fullText,
                      style: const TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 21,
                          fontFamily: 'MM'),
                    ))
                  ],
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
