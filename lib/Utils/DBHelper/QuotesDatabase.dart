import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:sqflite/sqflite.dart';

class QuotesDatabase
{

  static QuotesDatabase quotesDatabase = QuotesDatabase._();

  QuotesDatabase._();

  Database? database;
  Future<Database?> CheckDatabase() async
  {
    if(database != null)
      {
        return database;
      }
    else
      {
        return await CreateDatabase();
      }
  }

  Future<Database> CreateDatabase() async
  {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,'quotes.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query = "CREATE TABLE quotes (id INTEGER PRIMARY KEY AUTOINCREMENT, quote TEXT, category_id INTEGER)";
        db.execute(query);
      },
    );
  }

  void InsertQutesData({required String Quote, required int Category_Id}) async
  {
    database = await CheckDatabase();

    database!.insert('quotes', {'quote' : Quote, 'category_id' : Category_Id});
  }

  Future<List> ReadQuoteData() async
  {
    database = await CheckDatabase();

    String query = "SELECT * FROM quotes";
    List QuoteList = await database!.rawQuery(query);

    return QuoteList;
  }

  void DeleteQuoteData({required int id}) async
  {
    database = await CheckDatabase();

    database!.delete('quotes',where: "id = ?", whereArgs: [id]);


  }

  void UpdateQuoteData({required int id, required String Quote, required int Category_Id}) async
  {
    database = await CheckDatabase();

    database!.update('quotes', {'quote' : Quote, 'category_id' : Category_Id},where: "id = ?", whereArgs: [id]);


  }
}