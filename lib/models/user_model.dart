class UserModel {
  final String userId;
  final String email;
  final String name;
  final String image;
  final String lastMessageTime;
  UserModel({
    required this.email,
    required this.name,
    required this.image,
    required this.userId,
    required this.lastMessageTime,
  });
}
