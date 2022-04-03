import 'package:projeto_integrador_app/app/domain/entities/genre.dart';

class BookToGenre {
  int? id;
  int? bookId;
  int? genreId;
  Genre? genre;

  BookToGenre({
    this.id,
    this.bookId,
    this.genreId,
    this.genre,
  });

  BookToGenre.fromMap(dynamic obj) {
    id = obj['book_to_genre_id'];
    bookId = obj['book_id'];
    genreId = obj['genre_id'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'book_id': bookId,
      'genre_id': genreId,
    };

    return map;
  }
}
