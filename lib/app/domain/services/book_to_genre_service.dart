import 'package:projeto_integrador_app/app/domain/entities/book_to_genre.dart';
import 'package:projeto_integrador_app/app/domain/repositories/book_to_genre_repository.dart';
import 'package:projeto_integrador_app/app/domain/repositories/genre_repository.dart';

class BookToGenreService {
  final _bookToGenreRepository = BookToGenreRepository();
  final _genreRepository = GenreRepository();

  save(BookToGenre shelf) async {
    if (shelf.id == null) {
      return await _bookToGenreRepository.insert(shelf);
    }
    await _bookToGenreRepository.update(shelf);
  }

  remove(int id) async {
    await _bookToGenreRepository.remove(id);
  }

  Future<List<BookToGenre>> findAll() {
    return _bookToGenreRepository.findAll();
  }

  Future<List<BookToGenre>> findAllByBookId(int? bookId) async {
    var bookToGenres = await _bookToGenreRepository.findAllByBookId(bookId);

    for (var bg in bookToGenres) {
      bg.genre = await _genreRepository.findById(bg.genreId);
    }

    return bookToGenres;
  }
}
