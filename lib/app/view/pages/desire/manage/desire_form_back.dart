import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/enums/book_item_type.dart';
import 'package:projeto_integrador_app/app/domain/entities/book.dart';
import 'package:projeto_integrador_app/app/domain/entities/book_to_genre.dart';
import 'package:projeto_integrador_app/app/domain/entities/genre.dart';
import 'package:projeto_integrador_app/app/domain/services/book_service.dart';
import 'package:projeto_integrador_app/app/domain/services/book_to_genre_service.dart';
import 'package:projeto_integrador_app/app/domain/services/genre_service.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';

class DesireFormBack {
  Book? book;
  final _service = BookService();
  final _serviceGenre = GenreService();
  final _serviceBookToGenre = BookToGenreService();

  DesireFormBack(BuildContext context) {
    var parameter = ModalRoute.of(context)!.settings.arguments;
    book = (parameter == null) ? Book() : parameter as Book?;
  }

  Future<List<Genre>> findAllGenre() {
    return _serviceGenre.findAll();
  }

  Future<List<String>> findAllISBN() {
    return _service.findAllISBN(book!.id);
  }

  Future<List<BookToGenre>> findAllByBookId(int? bookId) {
    return _serviceBookToGenre.findAllByBookId(bookId);
  }

  goToForm(BuildContext context, [Book? book]) {
    Navigator.of(context)
        .pushReplacementNamed(Routes.DESIRE_FORM, arguments: book);
  }

  save(BuildContext context) async {
    try {
      book!.itemType = BookItemType.desire;
      await _service.save(book!);
      CommonService.messageSuccess(context, 'Livro salvo com sucesso!');
      Navigator.of(context).pop();
    } catch (e) {
      CommonService.messageError(context, 'Falha ao salvar livro! $e');
      Navigator.of(context).pop();
    }
  }
}
