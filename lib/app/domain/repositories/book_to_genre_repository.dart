import 'package:projeto_integrador_app/app/database/connection.dart';
import 'package:projeto_integrador_app/app/domain/entities/book_to_genre.dart';
import 'package:sqflite/sqlite_api.dart';

class BookToGenreRepository {
  final Connection _connection = Connection.instance;

  Future<Database> _getDatabase() async {
    return await _connection.database;
  }

  final _table = 'book_to_genre';

  Future<List<BookToGenre>> findAll() async {
    final _db = await _getDatabase();

    List<Map<String, dynamic>> allRows = await _db.query(_table);

    List<BookToGenre> bookToGenres =
        allRows.map((bookToGenre) => BookToGenre.fromMap(bookToGenre)).toList();

    return bookToGenres;
  }

  Future<List<BookToGenre>> findAllByBookId(int? bookId) async {
    final _db = await _getDatabase();

    List<Map<String, dynamic>> allRows =
        await _db.query(_table, where: 'book_id=?', whereArgs: [bookId]);

    List<BookToGenre> bookToGenres =
        allRows.map((bookToGenre) => BookToGenre.fromMap(bookToGenre)).toList();

    return bookToGenres;
  }

  remove(int? id) async {
    final _db = await _getDatabase();
    _db.delete(_table, where: "book_to_genre_id=?", whereArgs: [id]);
  }

  insert(BookToGenre bookToGenre) async {
    final _db = await _getDatabase();
    _db.insert(_table, bookToGenre.toMap());
  }

  update(BookToGenre bookToGenre) async {
    final _db = await _getDatabase();
    _db.update(_table, bookToGenre.toMap(),
        where: "book_to_genre_id=?", whereArgs: [bookToGenre.id]);
  }
}
