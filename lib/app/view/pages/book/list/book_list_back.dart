import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_integrador_app/app/common/enums/book_item_type.dart';
import 'package:projeto_integrador_app/app/domain/entities/book.dart';
import 'package:projeto_integrador_app/app/domain/models/filter_model.dart';
import 'package:projeto_integrador_app/app/domain/services/book_service.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';
part 'book_list_back.g.dart';

class BookListBack = _BookListBack with _$BookListBack;
FilterModel? filterCache;

abstract class _BookListBack with Store {
  final _service = BookService();
  FilterModel filterModel = filterCache ?? FilterModel();

  @observable
  Future<List<Book>>? list;

  @action
  refleshList([dynamic value]) {
    filterCache = filterModel;
    list = _service.findAll(BookItemType.bought, filterModel);
  }

  _BookListBack() {
    refleshList();
  }

  handlerCleanFilter() {
    filterCache = FilterModel();
    filterModel = FilterModel();
    refleshList();
  }

  goToForm(BuildContext context, [Book? book]) {
    Navigator.of(context)
        .pushNamed(Routes.BOOK_FORM, arguments: book)
        .then(refleshList);
  }

  goToView(BuildContext context, [Book? book]) {
    Navigator.of(context)
        .pushNamed(Routes.BOOK_VIEW, arguments: book)
        .then(refleshList);
  }

  remove(dynamic id, BuildContext context) async {
    try {
      await _service.remove(id);
      refleshList();
      Navigator.of(context).pop();
      CommonService.messageSuccess(context, 'Livro deletado com sucesso!');
    } catch (e) {
      CommonService.messageSuccess(context, 'Falha ao deletar livro! $e!');
      Navigator.of(context).pop();
    }
  }
}
