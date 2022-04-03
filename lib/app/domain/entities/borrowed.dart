import 'package:projeto_integrador_app/app/domain/entities/book.dart';

class Borrowed {
  int? id;
  int? bookId;
  Book? book;
  String? name;
  DateTime? borrowedDate;
  DateTime? returnedDate;

  Borrowed({
    this.id,
    this.bookId,
    this.book,
    this.name,
    this.borrowedDate,
    this.returnedDate,
  });

  Borrowed.fromMap(dynamic obj) {
    id = obj['borrowed_id'];
    bookId = obj['book_id'];
    name = obj['name'];
    borrowedDate = _millisecondsToDatetime(obj['borrowed_date'] as int?);
    returnedDate = _millisecondsToDatetime(obj['returned_date'] as int?);
    book = Book.fromMap(obj);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'book_id': bookId,
      'name': name,
      'borrowed_date': _datetimeToMilliseconds(borrowedDate),
      'returned_date': _datetimeToMilliseconds(returnedDate),
    };

    return map;
  }

  _millisecondsToDatetime(int? date) {
    if (date == null) {
      return date;
    }
    return DateTime.fromMillisecondsSinceEpoch(date);
  }

  _datetimeToMilliseconds(DateTime? date) {
    if (date == null) {
      return date;
    }
    return date.millisecondsSinceEpoch;
  }
}
