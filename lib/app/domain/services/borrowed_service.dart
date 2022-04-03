import 'package:projeto_integrador_app/app/domain/entities/book.dart';
import 'package:projeto_integrador_app/app/domain/entities/borrowed.dart';
import 'package:projeto_integrador_app/app/domain/repositories/book_repository.dart';
import 'package:projeto_integrador_app/app/domain/repositories/borrowed_repository.dart';

class BorrowedService {
  final _borrowedRepository = BorrowedRepository();
  final _bookRepository = BookRepository();

  save(Borrowed borrowed) async {
    if (borrowed.id == null) {
      return await _borrowedRepository.insert(borrowed);
    }
    await _borrowedRepository.update(borrowed);
  }

  remove(int? id) async {
    await _borrowedRepository.remove(id);
  }

  Future<List<Borrowed>> findAll() async {
    List<Borrowed> borroweds = await _borrowedRepository.findAllOpen();
    return borroweds;
  }

  Future<List<Book>> findAllBookAvailable(int? borrowedBookId) async {
    var borroweds = await _borrowedRepository.findAllOpen();
    var query = "item_type='bought'";

    if (borroweds.isNotEmpty) {
      query += " AND book_id not in (";
      var count = 0;
      for (var item in borroweds) {
        if (item.id != borrowedBookId) {
          query =
              count == 0 ? '$query${item.bookId}' : '$query, ${item.bookId}';
          count++;
        }
      }
      query += ")";
    }

    return _bookRepository.findAllBookAvailable(query);
  }
}
