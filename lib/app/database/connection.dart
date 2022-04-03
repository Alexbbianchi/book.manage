import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Connection {
  Connection._();

  static final Connection instance = Connection._();

  final _databaseName = 'database';
  final _databaseVersion = 1;

  static Database? _database;

  get database async {
    if (_database != null) {
      return _database;
    }
    return await _initDatabase();
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    // deleta o diretório do banco
    // deleteDatabase(path);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute(_genre);
    await db.execute(_book);
    await db.execute(_bookToGenre);
    await db.execute(_shelf);
    await db.execute(_shelfToBook);
    await db.execute(_borrowed);

    await db.insert('genre', {'name': 'Romance'});
    await db.insert('genre', {'name': 'Terror'});
    await db.insert('genre', {'name': 'Ficção'});
    await db.insert('genre', {'name': 'Ficção Cientifica'});
    await db.insert('genre', {'name': 'Poesia'});
    await db.insert('genre', {'name': 'Conto'});
    await db.insert('genre', {'name': 'Crônica'});
    await db.insert('genre', {'name': 'Biografia'});
    await db.insert('genre', {'name': 'Aventura'});
    await db.insert('genre', {'name': 'Literatura Nacional'});
    await db.insert('genre', {'name': 'História em Quadrinho'});
    await db.insert('genre', {'name': 'Literatura infantil'});
    await db.insert('genre', {'name': 'Thriller'});
    await db.insert('genre', {'name': 'Suspense Policial'});
    await db.insert('genre', {'name': 'Suspense'});

    // await db.execute(insertBook);
    // await db.execute(insertBook1);

    // await db.execute(insertBookIt);
    // await db.execute(insertBookMS);
    // await db.execute(insertBookGiz);

    // await db.execute(insertBookToGenre1);
    // await db.execute(insertBookToGenre2);
    // await db.execute(insertBookToGenre3);

    // await db.execute(insertShelf);
    // await db.execute(insertShelfToBook);
    // await db.execute(insertBorrowed);
  }

  String get _book => '''
    CREATE TABLE book(
      book_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      title VARCHAR(100) NOT NULL,
      author VARCHAR(100) NOT NULL,
      publishing_company VARCHAR(50),
      isbn VARCHAR(20) UNIQUE,
      format VARCHAR DEFAULT 'paperback' NOT NULL,
      publication_date INTEGER,
      pages INTEGER DEFAULT 0,
      language VARCHAR DEFAULT 'portuguese' NOT NULL,
      serie VARCHAR(50),
      volume INTEGER,
      description VARCHAR,
      image VARCHAR,
      start_date INTEGER,
      end_date INTEGER,
      pages_read INTEGER DEFAULT 0,
      status VARCHAR DEFAULT 'notRead' NOT NULL,
      item_type VARCHAR DEFAULT 'bought' NOT NULL,
      evaluation DOUBLE,
      notes VARCHAR
    );
  ''';

  String get _genre => '''
    CREATE TABLE genre(
      genre_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      name VARCHAR(20) UNIQUE NOT NULL
    );
  ''';

  String get _bookToGenre => '''
    CREATE TABLE book_to_genre(
      book_to_genre_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      book_id INTEGER NOT NULL,
      genre_id INTEGER NOT NULL,
      foreign key(book_id) references book(id) ON DELETE CASCADE,
      foreign key(genre_id) references genre(id) ON DELETE CASCADE
    );
  ''';

  String get _shelf => '''
    CREATE TABLE shelf(
      shelf_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      name VARCHAR(20) UNIQUE NOT NULL
    );
  ''';

  String get _shelfToBook => '''
    CREATE TABLE shelf_to_book(
      shelf_to_book_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      shelf_id INTEGER NOT NULL,
      book_id INTEGER NOT NULL,
      foreign key(shelf_id) references shelf(id) ON DELETE CASCADE,
      foreign key(book_id) references book(id) ON DELETE CASCADE
    );
  ''';

  String get _borrowed => '''
    CREATE TABLE borrowed(
      borrowed_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      book_id INTEGER NOT NULL,
      name VARCHAR(50) NOT NULL,
      borrowed_date INTEGER NOT NULL,
      returned_date INTEGER,
      foreign key(book_id) references book(id) ON DELETE CASCADE
    );
  ''';
}
