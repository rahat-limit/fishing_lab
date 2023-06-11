import 'package:uuid/uuid.dart';

const uuid = Uuid();

class TipModel {
  final String id;
  final String shortText;
  final String fullText;
  final String path;

  TipModel(
      {required this.shortText, required this.fullText, required this.path})
      : id = uuid.v4();
}
