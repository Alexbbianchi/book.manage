import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/domain/entities/book.dart';
import 'package:projeto_integrador_app/app/domain/entities/borrowed.dart';
import 'package:projeto_integrador_app/app/domain/services/borrowed_service.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';

// flutter pub run build_runner build
class BorrowedFormBack {
  Borrowed? borrowed;
  final _service = BorrowedService();

  BorrowedFormBack(BuildContext context) {
    var parameter = ModalRoute.of(context)!.settings.arguments;
    borrowed = (parameter == null) ? Borrowed() : parameter as Borrowed?;
  }

  Future<List<Book>> findAllBookAvailable(int? id) {
    return _service.findAllBookAvailable(id);
  }

  goToForm(BuildContext context, [Borrowed? borrowed]) {
    Navigator.of(context)
        .pushReplacementNamed(Routes.BORROWED_FORM, arguments: borrowed);
  }

  save(BuildContext context) async {
    try {
      await _service.save(borrowed!);
      CommonService.messageSuccess(context, 'Empréstimo salvo com sucesso!');
      Navigator.of(context).pop();
    } catch (e) {
      CommonService.messageError(context, 'Falha ao salvar empréstimo! $e');
      Navigator.of(context).pop();
    }
  }
}
