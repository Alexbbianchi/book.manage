import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_integrador_app/app/common/enums/book_item_type.dart';
import 'package:projeto_integrador_app/app/domain/entities/book.dart';
import 'package:projeto_integrador_app/app/domain/entities/shelf.dart';
import 'package:projeto_integrador_app/app/domain/entities/shelf_to_book.dart';
import 'package:projeto_integrador_app/app/domain/services/book_service.dart';
import 'package:projeto_integrador_app/app/domain/services/shelf_to_book_service.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';
part 'shelf_to_book_list_back.g.dart';

class ShelfToBookListBack = _ShelfToBookListBack with _$ShelfToBookListBack;

// flutter pub run build_runner build
abstract class _ShelfToBookListBack with Store {
  final _shelfToBookService = ShelfToBookService();
  final _bookService = BookService();

  late Shelf shelf;

  @observable
  Future<List<ShelfToBook>>? list;

  @action
  refleshList() {
    list = _shelfToBookService.findAllByShelfId(shelf.id);
  }

  Future<List<Book>> findAllBook() {
    return _bookService.findAll(BookItemType.bought);
  }

  _ShelfToBookListBack(BuildContext context) {
    var parameter = ModalRoute.of(context)!.settings.arguments;
    shelf = (parameter == null) ? Shelf() : parameter as Shelf;
    refleshList();
  }

  save(BuildContext context, List<int?> books) async {
    try {
      await _shelfToBookService.save(shelf.id, books);
      CommonService.messageSuccess(context, 'Estante salvo com sucesso!');
      refleshList();
      // Navigator.of(context).pop();
    } catch (e) {
      CommonService.messageError(context, 'Falha ao salvar estante! $e');
      Navigator.of(context).pop();
    }
  }
}
