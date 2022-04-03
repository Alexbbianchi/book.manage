import 'package:projeto_integrador_app/app/database/connection.dart';
import 'package:projeto_integrador_app/app/domain/entities/shelf_to_book.dart';
import 'package:sqflite/sqlite_api.dart';

class ShelfToBookRepository {
  final Connection _connection = Connection.instance;

  Future<Database> _getDatabase() async {
    return await _connection.database;
  }

  final _table = 'shelf_to_book';

  Future<List<ShelfToBook>> findAll() async {
    final _db = await _getDatabase();

    String query = '''
      SELECT * FROM $_table
        INNER JOIN book ON $_table.book_id = book.book_id
    ''';

    List<Map<String, dynamic>> allRows = await _db.rawQuery(query);
    List<ShelfToBook> shelfToBooks =
        allRows.map((shelfToBook) => ShelfToBook.fromMap(shelfToBook)).toList();
    return shelfToBooks;
  }

  Future<List<ShelfToBook>> findAllByShelfId(int? shelfId) async {
    final _db = await _getDatabase();

    String query = '''
      SELECT * FROM $_table
        INNER JOIN book ON $_table.book_id = book.book_id
      WHERE shelf_Id = '$shelfId'
    ''';

    List<Map<String, dynamic>> allRows = await _db.rawQuery(query);

    List<ShelfToBook> shelfToBooks =
        allRows.map((shelfToBook) => ShelfToBook.fromMap(shelfToBook)).toList();

    return shelfToBooks;
  }

  remove(int? id) async {
    final _db = await _getDatabase();
    _db.delete(_table, where: "shelf_to_book_id=?", whereArgs: [id]);
  }

  removeByShelfId(int? shelfId) async {
    final _db = await _getDatabase();
    _db.delete(_table, where: "shelf_id=?", whereArgs: [shelfId]);
  }

  removeByBookId(int? bookId) async {
    final _db = await _getDatabase();
    _db.delete(_table, where: "book_id=?", whereArgs: [bookId]);
  }

  insert(ShelfToBook shelfToBook) async {
    final _db = await _getDatabase();
    _db.insert(_table, shelfToBook.toMap());
  }

  insertRange(List<ShelfToBook> shelfToBooks) async {
    final _db = await _getDatabase();

    for (var shelfToBook in shelfToBooks) {
      _db.insert(_table, shelfToBook.toMap());
    }
  }

  update(ShelfToBook shelfToBook) async {
    final _db = await _getDatabase();
    _db.update(_table, shelfToBook.toMap(),
        where: "shelf_to_book_id=?", whereArgs: [shelfToBook.id]);
  }
}
