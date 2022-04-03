import 'package:enum_to_string/enum_to_string.dart';
import 'package:projeto_integrador_app/app/common/enums/book_format_type.dart';
import 'package:projeto_integrador_app/app/common/enums/book_item_type.dart';
import 'package:projeto_integrador_app/app/common/enums/book_language_type.dart';
import 'package:projeto_integrador_app/app/common/enums/book_status_type.dart';

class Book {
  int? id;
  String? title;
  String? author;
  String? publishingCompany;
  String? isbn;
  List<int?>? genres;
  List<String?>? notes;
  BookFormatType? format;
  DateTime? publicationDate;
  int? pages;
  BookLanguageType? language;
  String? serie;
  int? volume;
  String? description;
  String? image;
  DateTime? startDate;
  DateTime? endDate;
  int? pagesRead;
  BookStatusType? status;
  double? evaluation;
  BookItemType? itemType;

  Book({
    this.id,
    this.title,
    this.author,
    this.publishingCompany,
    this.isbn,
    this.genres,
    this.notes,
    this.format = BookFormatType.paperback,
    this.publicationDate,
    this.pages = 0,
    this.language = BookLanguageType.portuguese,
    this.serie,
    this.volume = 0,
    this.description,
    this.image,
    this.startDate,
    this.endDate,
    this.pagesRead = 0,
    this.status = BookStatusType.notRead,
    this.evaluation,
    this.itemType,
  });

  Book.fromMap(dynamic obj) {
    id = obj['book_id'] as int?;
    title = obj['title'] as String?;
    author = obj['author'] as String?;
    publishingCompany = obj['publishing_company'] as String?;
    isbn = obj['isbn'] as String?;
    notes = obj['notes'] != null ? obj['notes'].toString().split('|||') : [''];
    format =
        EnumToString.fromString(BookFormatType.values, obj['format'] as String);
    publicationDate = _millisecondsToDatetime(obj['publication_date'] as int?);
    pages = obj['pages'] as int?;
    language = EnumToString.fromString(
        BookLanguageType.values, obj['language'] as String);
    serie = obj['serie'] as String?;
    volume = obj['volume'] as int?;
    description = obj['description'] as String?;
    image = obj['image'] as String?;
    startDate = _millisecondsToDatetime(obj['start_date'] as int?);
    endDate = _millisecondsToDatetime(obj['end_date'] as int?);
    pagesRead = obj['pages_read'] as int?;
    status =
        EnumToString.fromString(BookStatusType.values, obj['status'] as String);
    evaluation = obj['evaluation'];
    itemType = EnumToString.fromString(
        BookItemType.values, obj['item_type'] as String);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'author': author,
      'publishing_company': publishingCompany,
      'isbn': isbn,
      'notes': _replaceNotes(notes),
      'format': format.cod,
      'publication_date': _datetimeToMilliseconds(publicationDate),
      'pages': pages,
      'language': language.cod,
      'serie': serie,
      'volume': volume,
      'description': description,
      'image': image,
      'start_date': _datetimeToMilliseconds(startDate),
      'end_date': _datetimeToMilliseconds(endDate),
      'pages_read': pagesRead,
      'status': status.cod,
      'evaluation': evaluation,
      'item_type': itemType.cod
    };

    return map;
  }

  _replaceNotes(List<String?>? notes) {
    if (notes == null) {
      return notes;
    }

    return notes.map((e) => e!.replaceAll('|||', '')).join('|||');
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
