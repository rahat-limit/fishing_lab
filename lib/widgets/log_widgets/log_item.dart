import 'package:fishing_lab/constants/colors.dart';
import 'package:fishing_lab/constants/functions.dart';
import 'package:fishing_lab/models/log_model.dart';
import 'package:fishing_lab/widgets/log_widgets/log_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogItem extends StatelessWidget {
  final LogModel log;
  final VoidCallback delete;
  const LogItem({super.key, required this.log, required this.delete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showBottomModal(context, LogInfo(log: log));
      },
      onDoubleTap: delete,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: lightScaffoldColor),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                    log.title,
                    maxLines: 2,
                    style: const TextStyle(
                        color: mainColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MM'),
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  log.image != null
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xff5B4F7D),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            'picture',
                            style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MM',
                                fontSize: 14),
                          ),
                        )
                      : log.fishName.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                'fish',
                                style: TextStyle(
                                    color: mainColor,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontFamily: 'MM',
                                    fontSize: 15),
                              ),
                            )
                          : const SizedBox()
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                      child: Text(
                    log.description,
                    maxLines: 3,
                    style: const TextStyle(
                        color: lightMainColor, fontSize: 16, fontFamily: 'MM'),
                  )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(DateFormat.yMMMMEEEEd().format(log.date),
                      style: const TextStyle(
                          color: mainColor, fontWeight: FontWeight.w700))
                ],
              )
            ]),
      ),
    );
  }
}
