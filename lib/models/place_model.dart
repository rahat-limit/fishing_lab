import 'package:fishing_lab/models/location_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String id;
  final String title;
  final LocationModel location;
  int priority;

  Place(
      {String? id,
      required this.title,
      required this.location,
      this.priority = 0})
      : id = id ?? uuid.v4();
}
