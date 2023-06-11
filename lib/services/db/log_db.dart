import 'dart:io';
import 'package:fishing_lab/models/log_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class LogsLocalStorage {
  Future<sql.Database> init() async {
    try {
      final dbPath = await sql.getDatabasesPath();
      final db = await sql.openDatabase(path.join(dbPath, 'logs.db'),
          onCreate: (db, version) async {
        return await db.execute(
            'CREATE TABLE logs(id TEXT PRIMARY KEY, title TEXT, description TEXT, date TEXT, fishName TEXT, fishLong TEXT, fishWeight TEXT, image TEXT)');
      }, version: 2);
      return db;
    } catch (e) {
      rethrow;
    }
  }

  Future insert({required LogModel log}) async {
    try {
      final db = await init();
      await db.insert('logs', {
        'id': log.id,
        'title': log.title,
        'description': log.description,
        'image': log.image != null ? log.image!.path : '',
        'fishName': log.fishName,
        'date': log.date.toString(),
        'fishLong': log.fishLong.toString(),
        'fishWeight': log.fishWeight.toString(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<LogModel>> getData() async {
    try {
      final db = await init();
      final data = await db.query('logs');
      final List<LogModel> logs = data.map((row) {
        return LogModel(
            id: row['id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            date: row['date'] == null
                ? DateTime.now()
                : DateTime.parse(row['date'] as String),
            fishName: row['fishName'] as String,
            image: File(row['image'] as String),
            fishLong: double.parse(row['fishLong'] as String),
            fishWeight: double.parse(row['fishWeight'] as String));
      }).toList();
      return logs;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteRow(String id) async {
    try {
      final db = await init();
      await db.delete('logs', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      rethrow;
    }
  }
}
