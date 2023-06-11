import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishing_lab/models/message_model.dart';

class ChatService {
  Future getKeys({required String fromIdUser}) async {
    final refUser = FirebaseFirestore.instance.collection('users');
    final fromUser = refUser.doc(fromIdUser);
    final dataFromUser = await fromUser.get();
    final fromKeys = dataFromUser.data()!['keys'] as Map<String, dynamic>;
    return fromKeys;
  }

  uploadMessage(
      {required String fromIdUser,
      required String toIdUser,
      required String fromUserName,
      required String message}) async {
    final refUser = FirebaseFirestore.instance.collection('users');
    final fromUser = refUser.doc(fromIdUser);
    final toUser = refUser.doc(toIdUser);
    final dataFromUser = await fromUser.get();
    final fromKeys = dataFromUser.data()!['keys'] as Map<String, dynamic>;

    final dataToUser = await toUser.get();
    final toKeys = dataToUser.data()!['keys'] as Map<String, dynamic>;

    final key = uuid.v4() + fromIdUser + toIdUser;

    if (!toKeys.containsKey(fromIdUser)) {
      toKeys.addAll({fromIdUser: key});
      await toUser.update({
        'last_message_time': DateTime.now(),
        'keys': toKeys,
      });
    }

    if (!fromKeys.containsKey(toIdUser)) {
      fromKeys.addAll({toIdUser: key});

      await fromUser.update({
        'last_messaage_time': DateTime.now(),
        'keys': fromKeys,
      });

      final refMessage =
          FirebaseFirestore.instance.collection('chats/$key/messages');
      final newMessage = MessageModel(
          toUserId: toIdUser,
          fromUserName: fromUserName,
          message: message,
          createdAt: DateTime.now());
      await refMessage.add(newMessage.toJson());
    } else {
      final refMessage = FirebaseFirestore.instance
          .collection('chats/${fromKeys[toIdUser]}/messages');
      final newMessage = MessageModel(
          toUserId: toIdUser,
          fromUserName: fromUserName,
          message: message,
          createdAt: DateTime.now());
      await refMessage.add(newMessage.toJson());
    }
  }
}
