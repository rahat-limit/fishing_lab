import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishing_lab/constants/colors.dart';
import 'package:fishing_lab/models/user_model.dart';
import 'package:fishing_lab/services/chat_service.dart';
import 'package:fishing_lab/widgets/appbar.dart';
import 'package:fishing_lab/widgets/chat_widgets/chat_bubble.dart';
import 'package:fishing_lab/widgets/chat_widgets/chat_input.dart';
import 'package:flutter/material.dart';

class ChattingScreen extends StatefulWidget {
  final UserModel toUser;
  const ChattingScreen({super.key, required this.toUser});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  TextEditingController? controller;
  User? currentUser;
  String? path;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    currentUser = FirebaseAuth.instance.currentUser;
    if (path == null) {
      final refUser = FirebaseFirestore.instance.collection('users');
      final fromUser = refUser.doc(currentUser!.uid);
      final dataFromUser = await fromUser.get();
      final fromKeys = dataFromUser.data()!['keys'] as Map<String, dynamic>;

      if (mounted) {
        setState(() {
          path = fromKeys[widget.toUser.userId];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void sendMessage() async {
      FocusScope.of(context).unfocus();
      final String text = controller!.text.trim();
      if (text.isEmpty) return;
      controller!.clear();

      await ChatService().uploadMessage(
          fromIdUser: currentUser!.uid,
          toIdUser: widget.toUser.userId,
          message: text,
          fromUserName: currentUser!.displayName ?? currentUser!.email!);
      didChangeDependencies();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: CustomAppBar(
          title: widget.toUser.name,
          actionButtons: const [],
          isChat: false,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Expanded(
                  child: SizedBox(
                width: double.infinity,
                child: path != null
                    ? StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('chats/$path/messages')
                            .orderBy('createdAt', descending: true)
                            // Problem -need to define solution of reverse path
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const SizedBox();
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.none) {
                            return const SizedBox();
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      'assets/images/sad.png',
                                    ),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    'Something went wrong:(',
                                    style: TextStyle(
                                        fontSize: 19, color: mainColor),
                                  ),
                                ],
                              ),
                            );
                          }

                          final loadedMessages = snapshot.data!.docs;
                          return ListView.builder(
                            reverse: true,
                            itemCount: loadedMessages.length,
                            itemBuilder: (context, index) {
                              return ChatBubble(
                                toUserId:
                                    loadedMessages[index].data()['toUserId'],
                                message:
                                    loadedMessages[index].data()['message'],
                                createdAt:
                                    loadedMessages[index].data()['createdAt'],
                                fromUserName: loadedMessages[index]
                                    .data()['fromUserName'],
                                currentUserId: currentUser!.uid,
                              );
                            },
                          );
                        },
                      )
                    : const SizedBox(),
              )),
              const SizedBox(
                height: 15,
              ),
              ChatInput(controller: controller!, callback: sendMessage),
            ],
          ),
        ),
      ),
    );
  }
}
