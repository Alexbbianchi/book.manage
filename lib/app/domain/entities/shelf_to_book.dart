import 'package:projeto_integrador_app/app/domain/entities/book.dart';

class ShelfToBook {
  int? id;
  int? shelfId;
  int? bookId;
  Book? book;

  ShelfToBook({
    this.id,
    this.shelfId,
    this.bookId,
    this.book,
  });

  ShelfToBook.fromMap(dynamic obj) {
    id = obj['shelf_to_book_id'];
    shelfId = obj['shelf_id'];
    bookId = obj['book_id'];
    book = Book.fromMap(obj);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'shelf_id': shelfId,
      'book_id': bookId,
    };

    return map;
  }
}
