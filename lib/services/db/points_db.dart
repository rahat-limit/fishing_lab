import 'package:fishing_lab/models/location_model.dart';
import 'package:fishing_lab/models/place_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class PointsLocalStorage {
  Future<sql.Database> init() async {
    try {
      final dbPath = await sql.getDatabasesPath();
      final db = await sql.openDatabase(path.join(dbPath, 'points.db'),
          onCreate: (db, version) async {
        return await db.execute(
            'CREATE TABLE points(id TEXT PRIMARY KEY, title TEXT, lat TEXT, lng TEXT, address TEXT, priority INTEGER)');
      }, version: 3);
      return db;
    } catch (e) {
      rethrow;
    }
  }

  Future insert({required Place place}) async {
    try {
      final db = await init();
      await db.insert('points', {
        'id': place.id,
        'title': place.title,
        'lat': place.location.lat.toString(),
        'lng': place.location.lng.toString(),
        'address': place.location.address,
        'priority': place.priority
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Place>> getData() async {
    try {
      final db = await init();
      final data = await db.query('points');
      final List<Place> places = data.map((row) {
        LocationModel location = LocationModel(
            lat: double.parse(row['lat'] as String),
            lng: double.parse(row['lng'] as String),
            address: row['address'] as String);
        return Place(
            id: row['id'] as String,
            title: row['title'] as String,
            location: location,
            priority: row['priority'] as int);
      }).toList();
      return places;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteRow(String id) async {
    try {
      final db = await init();
      await db.delete('points', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      rethrow;
    }
  }
}
