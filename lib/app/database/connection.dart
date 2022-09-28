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
    await db.execute(_genres);
    await db.execute(_books);
    await db.execute(_bookToGenres);
    await db.execute(_shelfs);
    await db.execute(_shelfToBooks);
    await db.execute(_borroweds);

    await db.insert('genres', {'name': 'Romance'});
    await db.insert('genres', {'name': 'Terror'});
    await db.insert('genres', {'name': 'Ficção'});
    await db.insert('genres', {'name': 'Ficção Cientifica'});
    await db.insert('genres', {'name': 'Poesia'});
    await db.insert('genres', {'name': 'Conto'});
    await db.insert('genres', {'name': 'Crônica'});
    await db.insert('genres', {'name': 'Biografia'});
    await db.insert('genres', {'name': 'Aventura'});
    await db.insert('genres', {'name': 'Literatura Nacional'});
    await db.insert('genres', {'name': 'História em Quadrinho'});
    await db.insert('genres', {'name': 'Literatura infantil'});
    await db.insert('genres', {'name': 'Thriller'});
    await db.insert('genres', {'name': 'Suspense Policial'});
    await db.insert('genres', {'name': 'Suspense'});

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

  String get _books => '''
    CREATE TABLE books(
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

  String get _genres => '''
    CREATE TABLE genres(
      genre_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      name VARCHAR(20) UNIQUE NOT NULL
    );
  ''';

  String get _bookToGenres => '''
    CREATE TABLE book_to_genres(
      book_to_genre_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      book_id INTEGER NOT NULL,
      genre_id INTEGER NOT NULL,
      foreign key(book_id) references book(id) ON DELETE CASCADE,
      foreign key(genre_id) references genre(id) ON DELETE CASCADE
    );
  ''';

  String get _shelfs => '''
    CREATE TABLE shelfs(
      shelf_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      name VARCHAR(20) UNIQUE NOT NULL
    );
  ''';

  String get _shelfToBooks => '''
    CREATE TABLE shelf_to_books(
      shelf_to_book_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      shelf_id INTEGER NOT NULL,
      book_id INTEGER NOT NULL,
      foreign key(shelf_id) references shelf(id) ON DELETE CASCADE,
      foreign key(book_id) references book(id) ON DELETE CASCADE
    );
  ''';

  String get _borroweds => '''
    CREATE TABLE borroweds(
      borrowed_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      book_id INTEGER NOT NULL,
      name VARCHAR(50) NOT NULL,
      borrowed_date INTEGER NOT NULL,
      returned_date INTEGER,
      foreign key(book_id) references book(id) ON DELETE CASCADE
    );
  ''';
}
