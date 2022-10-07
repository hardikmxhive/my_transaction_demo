import 'package:my_transaction_demo/transaction_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "transaction.db";
  static const String _tblName = "TransactionTbl";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE $_tblName(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL, amount INTEGER NOT NULL, type TEXT NOT NULL);"),
        version: _version);
  }

  static Future<int> addTransaction(TransactionModel transactionModel) async {
    final db = await _getDB();
    return await db.insert(_tblName, transactionModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateTransaction(
      TransactionModel transactionModel) async {
    final db = await _getDB();
    return await db.update(_tblName, transactionModel.toJson(),
        where: 'id = ?',
        whereArgs: [transactionModel.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTransaction(
      TransactionModel transactionModel) async {
    final db = await _getDB();
    return await db
        .delete(_tblName, where: 'id = ?', whereArgs: [transactionModel.id]);
  }

  static Future<List<TransactionModel>?> getAllTransactions() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(_tblName);

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => TransactionModel.fromJson(maps[index]));
  }
}
