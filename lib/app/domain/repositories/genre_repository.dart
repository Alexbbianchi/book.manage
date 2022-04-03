import 'package:projeto_integrador_app/app/database/connection.dart';
import 'package:projeto_integrador_app/app/domain/entities/genre.dart';
import 'package:sqflite/sqlite_api.dart';

class GenreRepository {
  final Connection _connection = Connection.instance;

  Future<Database> _getDatabase() async {
    return await _connection.database;
  }

  final _table = 'genre';

  Future<List<Genre>> findAll() async {
    Database _db = await _getDatabase();
    List<Map<String, dynamic>> allRows = await _db.query(_table);
    return allRows.map((genre) => Genre.fromMap(genre)).toList();
  }

  Future<Genre> findById(int? id) async {
    Database _db = await _getDatabase();
    List<Map<String, dynamic>> allRows =
        await _db.query(_table, where: 'genre_id=?', whereArgs: [id]);
    return allRows.map((genre) => Genre.fromMap(genre)).first;
  }
}
