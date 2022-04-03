import 'package:projeto_integrador_app/app/database/connection.dart';
import 'package:projeto_integrador_app/app/domain/entities/borrowed.dart';
import 'package:sqflite/sqflite.dart';

class BorrowedRepository {
  final Connection _connection = Connection.instance;

  Future<Database> _getDatabase() async {
    return await _connection.database;
  }

  final _table = 'borrowed';

  Future<List<Borrowed>> findAll() async {
    final _db = await _getDatabase();

    String query = '''
      SELECT * FROM $_table 
        INNER JOIN book ON $_table.book_id = book.book_id;
    ''';

    List<Map<String, dynamic>> allRows = await _db.rawQuery(query);
    return allRows.map((borrowed) => Borrowed.fromMap(borrowed)).toList();
  }

  Future<List<Borrowed>> findAllOpen() async {
    final _db = await _getDatabase();

    String query = '''
      SELECT * FROM $_table 
        INNER JOIN book ON $_table.book_id = book.book_id 
      WHERE $_table.returned_date is null;
    ''';

    List<Map<String, dynamic>> allRows = await _db.rawQuery(query);
    return allRows.map((borrowed) => Borrowed.fromMap(borrowed)).toList();
  }

  Future<Borrowed> findById(int id) async {
    final _db = await _getDatabase();

    String query = '''
      SELECT * FROM $_table 
        INNER JOIN book ON $_table.book_id = book.book_id  
      WHERE $_table.borrowed_id = $id;
    ''';

    List<Map<String, dynamic>> allRows = await _db.rawQuery(query);
    return allRows.map((borrowed) => Borrowed.fromMap(borrowed)).first;
  }

  remove(int? id) async {
    final _db = await _getDatabase();
    _db.delete(_table, where: "borrowed_id=?", whereArgs: [id]);
  }

  removeByBookId(int? bookId) async {
    final _db = await _getDatabase();
    _db.delete(_table, where: "book_id=?", whereArgs: [bookId]);
  }

  insert(Borrowed borrowed) async {
    final _db = await _getDatabase();
    _db.insert(_table, borrowed.toMap());
  }

  update(Borrowed borrowed) async {
    final _db = await _getDatabase();
    _db.update(_table, borrowed.toMap(),
        where: "borrowed_id=?", whereArgs: [borrowed.id]);
  }
}
