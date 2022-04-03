import 'package:projeto_integrador_app/app/domain/entities/shelf_to_book.dart';
import 'package:projeto_integrador_app/app/domain/repositories/shelf_to_book_repository.dart';

class ShelfToBookService {
  final _shelfToBookRepository = ShelfToBookRepository();

  save(int? shelfId, List<int?> books) async {
    if (shelfId == null || books.isEmpty) return;

    List<ShelfToBook> dbShelfToBooks = await findAllByShelfId(shelfId);

    var dicDbShelfToBooks = {
      for (var shelfToBook in dbShelfToBooks) shelfToBook.bookId: shelfToBook
    };

    for (var id in books) {
      if (!dicDbShelfToBooks.containsKey(id)) {
        await _shelfToBookRepository
            .insert(ShelfToBook(shelfId: shelfId, bookId: id));
      }

      dicDbShelfToBooks.remove(id);
    }

    for (var key in dicDbShelfToBooks.keys) {
      _shelfToBookRepository.remove(dicDbShelfToBooks[key]!.id);
    }
  }

  Future<List<ShelfToBook>> findAllByShelfId(int? shelfId) async {
    var shelfToBooks = await _shelfToBookRepository.findAllByShelfId(shelfId);
    return shelfToBooks;
  }
}
