import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class LogModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String fishName;
  final double fishLong;
  final double fishWeight;
  File? image;

  LogModel(
      {String? id,
      required this.title,
      required this.description,
      required this.date,
      required this.fishName,
      required this.fishLong,
      required this.fishWeight,
      this.image})
      : id = id ?? uuid.v4();
}
