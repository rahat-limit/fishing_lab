import 'package:uuid/uuid.dart';

const uuid = Uuid();

class MessageModel {
  final String id;
  final String toUserId;
  final String fromUserName;
  final String message;
  final DateTime createdAt;

  MessageModel(
      {required this.toUserId,
      required this.fromUserName,
      required this.message,
      required this.createdAt})
      : id = uuid.v4();
  Map<String, dynamic> toJson() => {
        'toUserId': toUserId,
        'fromUserName': fromUserName,
        'message': message,
        'createdAt': createdAt.toString(),
      };
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        toUserId: json['toUserId'],
        fromUserName: json['fromUserName'],
        message: json['message'],
        createdAt: json['createdAt']);
  }
}
