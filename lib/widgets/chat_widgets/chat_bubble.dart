import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String createdAt;
  final String toUserId;
  final String fromUserName;
  final String currentUserId;
  const ChatBubble(
      {super.key,
      required this.message,
      required this.createdAt,
      required this.toUserId,
      required this.fromUserName,
      required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: toUserId == currentUserId
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: tipBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topRight: const Radius.circular(15),
                        topLeft: const Radius.circular(15),
                        bottomLeft: toUserId == currentUserId
                            ? const Radius.circular(0)
                            : const Radius.circular(15),
                        bottomRight: toUserId == currentUserId
                            ? const Radius.circular(15)
                            : const Radius.circular(0))),
                child: Text(
                  message,
                  style: const TextStyle(
                      color: mainColor, fontSize: 17, fontFamily: 'MM'),
                ),
              ),
            ),
            toUserId == currentUserId
                ? const SizedBox(
                    width: 60,
                  )
                : const SizedBox(),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: toUserId == currentUserId
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            Text(
                '${currentUserId != toUserId ? 'You' : fromUserName}, ${DateTime.parse(createdAt).hour}:${DateTime.parse(createdAt).minute}',
                style: const TextStyle(color: mainColor, fontSize: 14)),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
