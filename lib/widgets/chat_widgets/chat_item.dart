import 'package:fishing_lab/constants/colors.dart';
import 'package:fishing_lab/models/user_model.dart';
import 'package:fishing_lab/screens/chatting_screen.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final UserModel toUser;
  const ChatItem({super.key, required this.toUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: lightScaffoldColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChattingScreen(
                        toUser: toUser,
                      )));
        },
        leading: const Image(
          image: AssetImage('assets/images/conversation.png'),
          width: 35,
          height: 35,
          fit: BoxFit.contain,
        ),
        title: Text(
          toUser.name,
        ),
        titleTextStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: mainColor,
            fontFamily: 'MM'),
        subtitle: Text(
          toUser.email,
          style: const TextStyle(
              color: lightMainColor, fontWeight: FontWeight.bold),
        ),
        trailing: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            '${DateTime.parse(toUser.lastMessageTime).hour}:${DateTime.parse(toUser.lastMessageTime).minute}',
            style: const TextStyle(color: mainColor),
          )
        ]),
      ),
    );
  }
}
