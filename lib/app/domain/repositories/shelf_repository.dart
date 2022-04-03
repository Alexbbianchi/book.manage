import 'package:projeto_integrador_app/app/database/connection.dart';
import 'package:projeto_integrador_app/app/domain/entities/shelf.dart';
import 'package:sqflite/sqflite.dart';

class ShelfRepository {
  final Connection _connection = Connection.instance;

  Future<Database> _getDatabase() async {
    return await _connection.database;
  }

  final _table = 'shelf';

  Future<List<Shelf>> findAll() async {
    final _db = await _getDatabase();

    List<Map<String, dynamic>> allRows = await _db.query(_table);

    return allRows.map((shelf) => Shelf.fromMap(shelf)).toList();
  }

  Future<Shelf> findById(int id) async {
    final _db = await _getDatabase();

    List<Map<String, dynamic>> allRows =
        await _db.query(_table, where: "shelf_id=?", whereArgs: [id]);

    return allRows.map((shelf) => Shelf.fromMap(shelf)).first;
  }

  remove(int? id) async {
    final _db = await _getDatabase();
    _db.delete(_table, where: "shelf_id=?", whereArgs: [id]);
  }

  insert(Shelf shelf) async {
    final _db = await _getDatabase();
    _db.insert(_table, shelf.toMap());
  }

  update(Shelf shelf) async {
    final _db = await _getDatabase();
    _db.update(_table, shelf.toMap(),
        where: "shelf_id=?", whereArgs: [shelf.id]);
  }
}
