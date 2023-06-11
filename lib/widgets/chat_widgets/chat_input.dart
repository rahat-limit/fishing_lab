import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback callback;
  const ChatInput(
      {super.key, required this.controller, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoTextField(
            padding: const EdgeInsets.all(15),
            controller: controller,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: mainColor,
            ),
            placeholder: 'Message',
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        IconButton(
          icon: const Icon(
            Icons.send,
            color: mainColor,
            size: 30,
          ),
          splashRadius: 25,
          onPressed: callback,
        )
      ],
    );
  }
}
