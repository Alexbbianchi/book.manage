import 'package:projeto_integrador_app/app/common/enums/book_item_type.dart';
import 'package:projeto_integrador_app/app/database/connection.dart';
import 'package:projeto_integrador_app/app/domain/entities/book.dart';
import 'package:sqflite/sqlite_api.dart';

class BookRepository {
  final Connection _connection = Connection.instance;

  Future<Database> _getDatabase() async {
    return await _connection.database;
  }

  final _table = 'book';

  Future<List<Book>> findAll(BookItemType itemType, String filter) async {
    Database _db = await _getDatabase();

    String query = '''
      SELECT * FROM $_table WHERE item_type = '${itemType.cod}' $filter
    ''';

    List<Map<String, dynamic>> allRows = await _db.rawQuery(query);
    return allRows.map((book) => Book.fromMap(book)).toList();
  }

  Future<List<String>> findAllISBN(int? id) async {
    Database _db = await _getDatabase();

    String query = 'SELECT * FROM $_table WHERE isbn is not null';

    if (id != null) {
      query += ' AND book_id != $id';
    }

    List<Map<String, dynamic>> allRows = await _db.rawQuery(query);
    return allRows
        .map((book) => Book.fromMap(book))
        .map((book) => book.isbn as String)
        .toList();
  }

  Future<List<Book>> findAllBookAvailable(String query) async {
    Database _db = await _getDatabase();

    List<Map<String, dynamic>> allRows = await _db.query(_table, where: query);
    return allRows.map((book) => Book.fromMap(book)).toList();
  }

  Future<Book> findById(int? id) async {
    Database _db = await _getDatabase();
    List<Map<String, dynamic>> allRows =
        await _db.query(_table, where: 'book_id=?', whereArgs: [id]);
    return allRows.map((book) => Book.fromMap(book)).first;
  }

  remove(int? id) async {
    Database _db = await _getDatabase();
    _db.delete(_table, where: "book_id=?", whereArgs: [id]);
  }

  Future<int> insert(Book book) async {
    Database _db = await _getDatabase();
    return _db.insert(_table, book.toMap());
  }

  update(Book book) async {
    Database _db = await _getDatabase();
    _db.update(_table, book.toMap(), where: "book_id=?", whereArgs: [book.id]);
  }
}
