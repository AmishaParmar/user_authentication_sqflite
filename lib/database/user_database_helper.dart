import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:user_authentication_sqflite/model/users.dart';

class DatabaseHelper {
  final databaseName = "auth.db";

  String user = "CREATE TABLE users (userId INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT, userEmail TEXT, userPassword TEXT)";

 static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  DatabaseHelper.internal();

   initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

   _createDB(Database db, int version) async{
    await db.execute(user);
  }

   
  //login
  Future<bool> loginUser(Users user) async{
      final Database db = await database;
    var result = await db.query('users', where: 'username = ? AND userPassword = ?', whereArgs: [user.userName, user.userPassword]);  
    // OR
    //var result = await db.rawQuery("select * from users where userName = ${user.userName} AND userPassword = ${user.userPassword}");

    if(result.isNotEmpty){
      return true;
    }
    else{
      return false;
    }
  }
   

  //Sign up 
  Future <int> createUser(Users user)async{
    final Database db = await database;
    return db.insert("users", user.toMap());
  }
  

  //Get current user details
  Future<Users?> getUser(String userName) async{
    final Database db = await database;
    var res = await db.query("users", where: "userName = ?",whereArgs: [userName]);
    return res.isNotEmpty? Users.fromMap(res.first):null;
  }
}
