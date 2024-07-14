import 'dart:io';
import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../Screens/QuotesAddScreen/Model/CategoryModel.dart';

class CategoryDatabse {
  static CategoryDatabse categoryDatabse = CategoryDatabse._();

  CategoryDatabse._();

  Database? database;
  Future<Database?> CheckDatabase() async {
    if (database != null) {
      return database;
    } else {
      return await CreateDatabase();
    }
  }

  Future<Database> CreateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'category.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT, categorytypes TEXT, image BLOB)";
        db.execute(query);
      },
    );
  }

  //Insert Data In Database
  void InsertDatabase({required String Category, String? image}) async {
    database = await CheckDatabase();

    Uint8List? Image;

    File file = File("$image");
    await file.readAsBytes().then((value) {
      Image = value;
    });

    database!.insert('category', {'categorytypes': Category, 'image': Image});
  }

  //Read Data In Database
  Future<List<CategoryModel>> ReadDatabase() async {
    database = await CheckDatabase();
    String query = "SELECT * FROM category";
    List<Map> dataList = await database!.rawQuery(query);

    List<CategoryModel> Data =
        dataList.map((e) => CategoryModel().fromMap(e)).toList();

    return Data;
  }

  //Delete Data In Database
  Future<void> DeleteDatabase({required int id}) async {
    database = await CheckDatabase();

    database!.delete('category', where: "id = ?", whereArgs: [id]);
  }

  //Update Data In Database(Simple Image)
  Future<void> UpdateDatabase(
      {required int id,
      required String Category,
      required String image}) async {
    database = await CheckDatabase();
    Uint8List? Image;

    File file = File("$image");
    await file.readAsBytes().then((value) {
      Image = value;
    });

    database!.update('category', {'categorytypes': Category, 'image': Image},
        whereArgs: [id], where: "id = ?");
  }

  //Update Data In Database(Blob Image)
  Future<void> UpdateBIDatabase(
      {required int id,
      required String Category,
      required Uint8List image}) async {
    database = await CheckDatabase();

    database!.update('category', {'categorytypes': Category, 'image': image},
        whereArgs: [id], where: "id = ?");
  }
}
