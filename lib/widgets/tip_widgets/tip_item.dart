import 'package:fishing_lab/constants/colors.dart';
import 'package:fishing_lab/constants/functions.dart';
import 'package:fishing_lab/models/tip_model.dart';
import 'package:fishing_lab/widgets/tip_widgets/tip_info.dart';
import 'package:flutter/material.dart';

class TipItem extends StatelessWidget {
  final TipModel tip;
  const TipItem({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showBottomModal(context, TipInfo(tip: tip));
      },
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                    tip.shortText,
                    maxLines: 1,
                    style: const TextStyle(
                        color: lightMainColor, fontSize: 14, fontFamily: 'MM'),
                  ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                    tip.fullText,
                    maxLines: 3,
                    style: const TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontFamily: 'MM'),
                  ))
                ],
              ),
            ],
          )),
          const SizedBox(
            width: 15,
          ),
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
        ]),
        const SizedBox(
          height: 20,
        ),
        const Divider(thickness: .8, height: 0, color: lightMainColor),
        const SizedBox(
          height: 25,
        ),
      ]),
    );
  }
}
