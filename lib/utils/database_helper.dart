import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/todo.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;  /// Singleton pattern ensures one instance of a class

  // private constructor
  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
      _databaseHelper ??= DatabaseHelper._createInstance();
      return _databaseHelper!;
  }

  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 7;

  static const table = 'my_table';

  static const columnId = 'columnId';
  static const columnTodoList = 'columnTodoList';
  static const columnIsDone = 'columnIsDone';

  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      // readOnly: true,
      onCreate: _onCreate,
    );
    return _db;
  }


  // Future<Database> _getDB() async{
  //   return openDatabase(join(await getDatabasesPath(), _databaseName),
  //     version: _databaseVersion,
  //     onCreate: _onCreate,
  //   );
  // }

  Future<List<Task>> getAllTask() async{
    // final db = await _getDB();
    final List<Map<String, dynamic>> maps = await _db.query(table);

    return List.generate(maps.length, (index) => Task.fromMapObject(maps[index]));
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId TEXT PRIMARY KEY,
            $columnTodoList TEXT,
            $columnIsDone INTEGER
          );
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    String id = row['columnId'];
    // print(id);
    return await _db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String id) async {
    return await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}