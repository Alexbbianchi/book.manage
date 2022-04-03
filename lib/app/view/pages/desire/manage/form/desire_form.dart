import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/desire_form_back.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/form/desire_details.dart';

class DesireForm extends StatelessWidget {
  const DesireForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _back = DesireFormBack(context);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _back.book!.id == null ? "Cadastrar desejo" : "Editar desejo",
        ),
        actions: [
          _back.book!.id != null
              ? IconButton(
                  tooltip: "Adicionar em adiquiridos",
                  icon: const Icon(Icons.bookmark_add_sharp),
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                    Routes.BOOK_FORM,
                    arguments: _back.book,
                  ),
                )
              : const Padding(padding: EdgeInsets.all(0)),
        ],
      ),
      body: Form(
        key: _formKey,
        child: DesireDetais(_back),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(16),
          ),
        ),
        onPressed: () {
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
