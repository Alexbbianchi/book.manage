import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/manage/borrowed_form_back.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/manage/form/borrowed_details.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';

class BorrowedForm extends StatelessWidget {
  const BorrowedForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _back = BorrowedFormBack(context);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _back.borrowed!.id == null
              ? "Cadastrar empréstimo"
              : "Editar empréstimo",
        ),
      ),
      body: Form(
        key: _formKey,
        child: BorrowedDetais(
          back: _back,
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(16),
          ),
        ),
        onPressed: () {
          if (_back.borrowed!.bookId == null) {
            CommonService.messageError(
                context, "Selecione um livro para salvar.");
            return;
          }
          if (_back.borrowed!.borrowedDate == null) {
            CommonService.messageError(context, "Informe uma data de início.");
            return;
          }
          var validate = _formKey.currentState!.validate();
          _formKey.currentState!.save();
          if (validate) {
            _back.save(context);
          }
        },
        child: const Text(
          'Salvar',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
