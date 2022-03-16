import 'package:sqflite/sqflite.dart' as sqlite;

class SQLHelper {
  static Future<sqlite.Database> db() async {
    return sqlite.openDatabase("info.db", version: 1,
        onCreate: (sqlite.Database database, int version) {
      database.execute(
          "CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, description TEXT, userId TEXT)");
      database.execute(
          "CREATE TABLE userdata (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, phone TEXT, email TEXT, password TEXT)");
    });
  }

  static Future<int> insertData(String title, String description,String userId) async {
    final db = await SQLHelper.db();
    var values = {"title": title, "description": description,"userId":userId};
    return db.insert("note", values);
  }

  static Future<List<Map<String, dynamic>>> getAllData(String userID) async {
    final db = await SQLHelper.db();
    return db.query("note", orderBy: "id",where: "userId = ?",whereArgs: [userID]);
  }

  static Future<int> updateData(
      int id, String title, String description) async {
    final db = await SQLHelper.db();
    var values = {"title": title, "description": description};
    return db.update("note", values, where: "id = ?", whereArgs: [id]);
  }

  static Future<int> deleteData(int id) async {
    final db = await SQLHelper.db();
    return db.delete("note", where: "id = ?", whereArgs: [id]);
  }

  //user table
  //insert data
  static Future<int> insertDataUser(
      String name, String phone, String email, String password) async {
    final db = await SQLHelper.db();
    var values = {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password
    };
    return db.insert("userdata", values);
  }

  //get data
  static Future<List<Map<String, dynamic>>> getAllDataUser() async {
    final db = await SQLHelper.db();
    return db.query("userdata", orderBy: "id");
  }

  static Future<dynamic> checkLogin(String userName, String password) async {
    final db = await SQLHelper.db();
    print("login data $userName => $password");
    var res = await db.rawQuery(
        "SELECT * FROM userdata WHERE email = '$userName' and password = '$password'");

    if (res.length > 0) {
      return res[0]["id"].toString();
    }

    return "";
  }
}