import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

List<TimeData> timeData=[];
DatabaseHelper databaseHelper;
List<int> selectedData=[0,0,0,0,0,0,0];
int hours=1,minutes=1;
ServerSocket serverSocket;
Socket socketClient;
List <bool> isSelected=[false,false,false,false,false,false,false];
/*int getId()
{
  List<int> id=[];
  databaseHelper.getTimeDataMapList().then((value){
    for (var map in value) {
      id.add(map['id']);
    }

    return id[id.length-1];
  });
}
*/


String getWeeks(int index) {
  String weeks ="";
      if (timeData[index].day1 == 1 ) {
        weeks=weeks+"Mon,";
      }
      if (timeData[index].day2 == 1) {
        weeks=weeks+"Tue,";
      }
      if (timeData[index].day3 == 1) {
        weeks=weeks+"Wen,";
      }
      if (timeData[index].day4 == 1) {
        weeks=weeks+"Thu,";
      }
      if (timeData[index].day5 == 1) {
        weeks=weeks+"Fri,";
      }
      if (timeData[index].day6 == 1) {
        weeks=weeks+"Sat,";
      }
      if (timeData[index].day7 == 1) {
        weeks=weeks+"Sun,";
      }

    print(weeks);
    return  weeks;

}

class TimeData {
  String id;
  int hour;
  int min;
  int durationmin;
  int durationsec;
  int day1;
  int day2;
  int day3;
  int day4;
  int day5;
  int day6;
  int day7;

  TimeData(
      {this.id,
        this.hour,
        this.min,
        this.durationmin,
        this.durationsec,
        this.day1,
        this.day2,
        this.day3,
        this.day4,
        this.day5,
        this.day6,
        this.day7,
        });
}

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'kalesh.db';

    // Open/create the database at a given path
    var notesDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE TimeData (id VARCHAR(30) , hour INTEGER, min INTEGER, durationmin INTEGER, durationsec INTEGER, day1 INTEGER,day2 INTEGER,day3 INTEGER,day4 INTEGER,day5 INTEGER,day6 INTEGER,day7 INTEGER)');
  }

  // Insert Operation: Insert a Note object to database


  Future<int> insertTimeData(TimeData timeData) async {
    Database db = await this.database;
    var result = await db.insert('TimeData', {
      'id':timeData.id,
      'hour': timeData.hour,
      'min': timeData.min,
      'durationmin': timeData.durationmin,
      'durationsec':timeData.durationsec,
      'day1': timeData.day1,
      'day2': timeData.day2,
      'day3': timeData.day3,
      'day4': timeData.day4,
      'day5': timeData.day5,
      'day6': timeData.day6,
      'day7': timeData.day7,

    });
    return result;
  }


  Future<List<Map<String, dynamic>>> getTimeDataMapList() async {
    Database db = await this.database;
    var result = await db.query('TimeData');
    return result;
  }



  Future<int> deleteTime(String id) async {
    var db = await this.database;
    int result =
    await db.rawDelete('DELETE FROM TimeData WHERE id = "$id"');
    return result;
  }
}

