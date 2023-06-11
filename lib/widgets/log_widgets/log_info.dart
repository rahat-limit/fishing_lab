import 'package:fishing_lab/constants/colors.dart';
import 'package:fishing_lab/models/log_model.dart';
import 'package:flutter/material.dart';

class LogInfo extends StatelessWidget {
  final LogModel log;
  const LogInfo({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                log.image == null
                    ? const SizedBox()
                    : const SizedBox(
                        width: 8,
                      ),
                log.image != null
                    ? Container(
                        constraints: const BoxConstraints(maxHeight: 250),
                        child: Image.file(log.image!, fit: BoxFit.contain))
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Flexible(
                            child: Text(
                          log.title,
                          style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w400,
                              color: mainColor,
                              fontFamily: 'BNR'),
                        )),
                      ],
                    )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Flexible(
                            child: Text(
                          log.description,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'MM',
                            color: mainColor,
                          ),
                        )),
                      ],
                    )),
                  ],
                ),
                log.fishName.isNotEmpty
                    ? const Divider(
                        height: 50,
                        color: Colors.white60,
                        thickness: 1,
                      )
                    : const SizedBox(),
                log.fishName.isEmpty
                    ? const SizedBox()
                    : Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(width: 1, color: mainColor),
                                ),
                                child: const Text('Fish Name',
                                    style: TextStyle(color: mainColor)),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                  child: Text(
                                log.fishName,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'MM',
                                    color: mainColor),
                              )),
                            ],
                          )),
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                log.fishName.isEmpty && log.fishLong == 0
                    ? const SizedBox()
                    : Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(width: 1, color: mainColor),
                                ),
                                child: const Text('Fish Long',
                                    style: TextStyle(color: mainColor)),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                  child: Text(
                                '${(log.fishLong / 100).roundToDouble()} m - ${(log.fishLong * 0.0328084).roundToDouble()} ft',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'MM',
                                    color: mainColor),
                              )),
                            ],
                          )),
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                log.fishName.isEmpty && log.fishWeight == 0
                    ? const SizedBox()
                    : Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(width: 1, color: mainColor),
                                ),
                                child: const Text(
                                  'Fish Weight',
                                  style: TextStyle(color: mainColor),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                  child: Text(
                                '${(log.fishWeight / 1000).roundToDouble()} kg - ${(log.fishWeight * 0.00220462).roundToDouble()} lb',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'MM',
                                    color: mainColor),
                              )),
                            ],
                          )),
                        ],
                      ),
                const SizedBox(
                  height: 25,
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
