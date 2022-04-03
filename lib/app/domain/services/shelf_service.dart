import 'package:projeto_integrador_app/app/domain/entities/shelf.dart';
import 'package:projeto_integrador_app/app/domain/repositories/book_repository.dart';
import 'package:projeto_integrador_app/app/domain/repositories/shelf_repository.dart';
import 'package:projeto_integrador_app/app/domain/repositories/shelf_to_book_repository.dart';

class ShelfService {
  final _shelfRepository = ShelfRepository();
  final _bookRepository = BookRepository();
  final _shelfToBookRepository = ShelfToBookRepository();

  save(Shelf shelf) async {
    if (shelf.id == null) {
      await _shelfRepository.insert(shelf);
      return;
    }

    await _shelfRepository.update(shelf);
  }

  remove(int? id) async {
    await _shelfRepository.remove(id);
    await _shelfToBookRepository.removeByShelfId(id);
  }

  Future<List<Shelf>> findAll() async {
    List<Shelf> shelfs = await _shelfRepository.findAll();

    for (var shelf in shelfs) {
      shelf.books = await _shelfToBookRepository.findAllByShelfId(shelf.id);
      for (var e in shelf.books!) {
        e.book = await _bookRepository.findById(e.bookId);
      }
    }
    return shelfs;
  }

  Future<Shelf> findById(int id) async {
    Shelf shelf = await _shelfRepository.findById(id);
    shelf.books = await _shelfToBookRepository.findAllByShelfId(shelf.id);
    for (var e in shelf.books!) {
      e.book = await _bookRepository.findById(e.bookId);
    }
    return shelf;
  }
}
