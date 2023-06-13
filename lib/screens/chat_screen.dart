import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishing_lab/constants/colors.dart';
import 'package:fishing_lab/models/user_model.dart';
import 'package:fishing_lab/services/chat_service.dart';
import 'package:fishing_lab/widgets/appbar.dart';
import 'package:fishing_lab/widgets/chat_widgets/chat_item.dart';
import 'package:fishing_lab/widgets/menu/custom_drawer.dart';
import 'package:fishing_lab/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class ChatScreen extends StatefulWidget {
  static const route = '/chat';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController? controller;
  User? currentUser;
  Map<String, dynamic>? keys;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    currentUser = FirebaseAuth.instance.currentUser;
    keys = await ChatService()
        .getKeys(fromIdUser: currentUser!.uid)
        .whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: CustomAppBar(
          title: 'Chat',
          actionButtons: const [],
          isChat: true,
        ),
      ),
      body: Column(children: [
        Search(
          controller: controller!,
          callback: (String text) {
            setState(() {});
          },
          // ignore: unrelated_type_equality_checks
          placeholder: context.currentLocale.toString().trim() == 'en'
              ? 'Enter an Email'
              : (context.currentLocale.toString().trim() == 'ru'
                  ? "Введите почту"
                  : 'Поштаны енгізіңіз'),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: StreamBuilder(
              stream: controller!.text.isNotEmpty
                  ? FirebaseFirestore.instance
                      .collection('users')
                      .where('email', whereIn: [controller!.text])
                      .limit(15)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('users')
                      .limit(15)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      Image(
                        image: AssetImage(
                          'assets/images/help.png',
                        ),
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: LocaleText(
                          'Oops, no people found!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 23, color: mainColor),
                        ),
                      ),
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return const SizedBox();
                }
                if (snapshot.hasError) {
                  return const Text('Something went wrong:(');
                }

                final loadedUsers = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: loadedUsers.length,
                  itemBuilder: (context, index) {
                    if (loadedUsers[index].id == currentUser!.uid) {
                      return const SizedBox();
                    }
                    final UserModel user = UserModel(
                        userId: loadedUsers[index].id,
                        email: loadedUsers[index].data()['email'],
                        name: loadedUsers[index].data()['name'] ?? 'No Name',
                        image: '',
                        lastMessageTime:
                            loadedUsers[index].data()['last_message_time'] ==
                                    null
                                ? DateTime.now().toString()
                                : loadedUsers[index]
                                    .data()['last_message_time']
                                    .toDate()
                                    .toString());
                    final ref = loadedUsers[index].data()['keys']
                        as Map<String, dynamic>;
                    if (ref[currentUser!.uid] != null) {
                      return ChatItem(
                        toUser: user,
                      );
                    } else {
                      if (controller!.text.trim().isNotEmpty) {
                        return ChatItem(
                          toUser: user,
                        );
                      } else {
                        return const SizedBox();
                      }
                    }
                  },
                );
              }),
        ))
      ]),
      drawer: const CustomDrawer(),
    );
  }
}
