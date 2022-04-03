import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_integrador_app/app/common/enums/book_item_type.dart';
import 'package:projeto_integrador_app/app/domain/entities/book.dart';
import 'package:projeto_integrador_app/app/domain/services/book_service.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';
part 'desire_list_back.g.dart';

class DesireListBack = _DesireListBack with _$DesireListBack;

abstract class _DesireListBack with Store {
  final _service = BookService();

  @observable
  Future<List<Book>>? list;

  @action
  refleshList([dynamic value]) {
    list = _service.findAll(BookItemType.desire);
  }

  _DesireListBack() {
    refleshList();
  }

  goToForm(BuildContext context, [Book? book]) {
    Navigator.of(context)
        .pushNamed(Routes.DESIRE_FORM, arguments: book)
        .then(refleshList);
  }

  goToView(BuildContext context, [Book? book]) {
    Navigator.of(context)
        .pushNamed(Routes.DESIRE_VIEW, arguments: book)
        .then(refleshList);
  }

  remove(dynamic id, BuildContext context) async {
    try {
      await _service.remove(id);
      refleshList();
      Navigator.of(context).pop();
      CommonService.messageSuccess(context, 'Item deletado com sucesso!');
    } catch (e) {
      CommonService.messageSuccess(context, 'Falha ao deletar item! $e!');
      Navigator.of(context).pop();
    }
  }
}
