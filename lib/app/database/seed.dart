const String morteSubita = '';

const String homemDeGiz = '';

const String itACoisa = '';

const insertBook = '''
INSERT INTO book (title, author, publishing_company, isbn, format, publication_date, pages, language, serie, volume, description, image, start_date, end_date, status, pages_read, item_type, notes)
VALUES ('Harry Potter e o prisioneiro de Azkaban', 'J.K. Rowling', 'Rocco', 'dfgdgd', 'ebook', 1594682971156, 50, 'portuguese', '3', 5, 'Ótimo livro', null, 1555962196, null, 'read', 50, 'bought', 'teste|||teste2');
''';

const insertBookToGenre1 = '''
INSERT INTO book_to_genre(book_id, genre_id) VALUES (1, 2);
''';
const insertBookToGenre2 = '''
INSERT INTO book_to_genre(book_id, genre_id) VALUES (1, 5);
''';

const insertBookToGenre3 = '''
INSERT INTO book_to_genre(book_id, genre_id) VALUES (1, 6);
''';

const insertBook1 = '''
INSERT INTO book (title, author, publishing_company, isbn, format, publication_date, pages, language, serie, volume, description, image, start_date, end_date, status, pages_read, item_type)
VALUES ('Harry Potter e o prisioneiro de Azkaban', 'J.K. Rowling', 'Rocco', 'dfgjdgd', 'ebook', 1594682971156, 50, 'portuguese', '3', 5, 'Ótimo livro', null, 1555962196, null, 'read', 0, 'desire');
''';

const insertShelf = '''
INSERT INTO shelf (name)
VALUES ('Teste');
''';

const insertShelfToBook = '''
INSERT INTO shelf_to_book (shelf_id, book_id)
VALUES (1, 1);
''';
const insertShelfToBook2 = '''
INSERT INTO shelf_to_book (shelf_id, book_id)
VALUES (1, 2);
''';
const insertShelfToBook3 = '''
INSERT INTO shelf_to_book (shelf_id, book_id)
VALUES (1, 3);
''';
const insertShelfToBook4 = '''
INSERT INTO shelf_to_book (shelf_id, book_id)
VALUES (1, 4);
''';

const insertBorrowed = '''
INSERT INTO borrowed (book_id, name, borrowed_date)
VALUES (1, 'Alex', 1555962196);
''';

//
const insertBookIt = '''
INSERT INTO book (title, author, publishing_company, isbn, format, publication_date, pages, language, serie, volume, description, image, start_date, end_date, status, pages_read, item_type)
VALUES ('It - A Coisa', 'Stephen King', 'Suma', '978-8560280941', 'paperback', 1594682971156, 1104, 'portuguese', '3', 5, 'Ótimo livro', null, 1555962196, null, 'read', 50, 'bought');
''';

const insertBookMS = '''
INSERT INTO book (title, author, publishing_company, isbn, format, publication_date, pages, language, serie, volume, description, image, start_date, end_date, status, pages_read, item_type)
VALUES ('Morte Súbita', 'J.K. Rowling', 'Casa dos Livros', '978-8560280940', 'paperback', 1594682971156, 512, 'portuguese', '3', 5, 'Ótimo livro', null, 1555962196, null, 'read', 50, 'bought');
''';

const insertBookGiz = '''
INSERT INTO book (title, author, publishing_company, isbn, format, publication_date, pages, language, serie, volume, description, image, start_date, end_date, status, pages_read, item_type)
VALUES ('O Homem de Giz', 'C.J. Tudor', 'Intrínseca', '978-8551002933', 'hardCover', 1594682971156, 272, 'portuguese', '3', 5, 'Ótimo livro', null, 1555962196, null, 'read', 50, 'bought');
''';
