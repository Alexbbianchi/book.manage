import 'package:projeto_integrador_app/app/common/enums/book_item_type.dart';
import 'package:projeto_integrador_app/app/domain/entities/book.dart';
import 'package:projeto_integrador_app/app/domain/entities/book_to_genre.dart';
import 'package:projeto_integrador_app/app/domain/models/filter_model.dart';
import 'package:projeto_integrador_app/app/domain/repositories/book_repository.dart';
import 'package:projeto_integrador_app/app/domain/repositories/book_to_genre_repository.dart';
import 'package:projeto_integrador_app/app/domain/repositories/borrowed_repository.dart';
import 'package:projeto_integrador_app/app/domain/repositories/shelf_to_book_repository.dart';

class BookService {
  final _bookRepository = BookRepository();
  final _bookToGenreRepository = BookToGenreRepository();
  final _shelfToBookRepository = ShelfToBookRepository();
  final _borrowedRepository = BorrowedRepository();

  save(Book book) async {
    // insert
    if (book.id == null) {
      var bookId = await _bookRepository.insert(book);

      if (book.genres == null) return;

      for (var genreId in book.genres!) {
        var newGenre = BookToGenre(bookId: bookId, genreId: genreId);
        await _bookToGenreRepository.insert(newGenre);
      }

      return;
    }

    // update
    await _bookRepository.update(book);

    List<BookToGenre> dbListGenres =
        await _bookToGenreRepository.findAllByBookId(book.id);

    var dicDBGenres = {for (var genre in dbListGenres) genre.genreId: genre};

    for (var genreId in book.genres!) {
      if (!dicDBGenres.containsKey(genreId)) {
        var newGenre = BookToGenre(bookId: book.id, genreId: genreId);
        await _bookToGenreRepository.insert(newGenre);
      }

      dicDBGenres.remove(genreId);
    }

    for (var key in dicDBGenres.keys) {
      _bookToGenreRepository.remove(dicDBGenres[key]!.id);
    }
  }

  remove(int? id) async {
    await _bookRepository.remove(id);
    await _shelfToBookRepository.removeByBookId(id);
    await _borrowedRepository.removeByBookId(id); // todo
  }

  Future<List<Book>> findAll(BookItemType itemType,
      [FilterModel? filterModel]) async {
    var filter = filterModel ?? FilterModel();

    List<Book> books = await _bookRepository.findAll(itemType, filter.filter);

    for (var book in books) {
      await _bookToGenreRepository
          .findAllByBookId(book.id)
          .then((genre) => book.genres = genre.map((e) => e.genreId).toList());
    }
    return books;
  }

  Future<List<String>> findAllISBN(int? id) async {
    return await _bookRepository.findAllISBN(id);
  }

  Future<Book> findById(int id) async {
    Book book = await _bookRepository.findById(id);
    await _bookToGenreRepository
        .findAllByBookId(book.id)
        .then((genre) => book.genres = genre.map((e) => e.genreId).toList());
    return book;
  }
}
