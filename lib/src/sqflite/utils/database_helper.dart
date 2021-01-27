import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_crud_api_sample_app/src/sqflite/models/details.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';


class DatabaseHelper{

  static DatabaseHelper _databaseHelper; //singleton helper

  DatabaseHelper._createInstance(); //named constructor to create instance of databasehelper

  String noteTable = 'note_table';
  String colId = 'id';
  String fullname = 'fullname';
  String email = 'email';
  String age = 'age';
  String priority = 'priority';
  String is_synced = 'issynced';
  String date ='date';

  static Database _database;

  factory DatabaseHelper()
  {
    if(_databaseHelper == null)
      {
        _databaseHelper = DatabaseHelper._createInstance(); // this is executed only once singleton object
      }

    return _databaseHelper;
  }

  Future<Database> initializeDatabase() async{

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
    var notesdb= openDatabase(path, version: 1, onCreate: _createDb );
    return notesdb;
  }

  Future<Database> get database async{
    if(_database==null)
    {
      _database = await initializeDatabase();
    }

    return _database;
  }


  void _createDb(Database database, int version) async
  {
    await database.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $fullname TEXT , '
    '$email TEXT,$age TEXT, $is_synced BOOLEAN, $priority INTEGER , $date TEXT)');
  }


  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$priority ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(Note note,int issynced) async {

    //debugPrint('coming insside'+note.notetitle+"--"+note.desc+"--"+note.priority.toString()+"--"+note.date);

    Database db = await this.database;
    //var result = await db.insert(noteTable, note.toMap());
    var result = await db.insert(noteTable, note.toMap());

    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Note note,int issynced) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Note>> getNoteList() async {

    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count = noteMapList.length;         // Count the number of map entries in db table

    List<Note> noteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

}