import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/domain/entities/shelf.dart';
import 'package:projeto_integrador_app/app/domain/services/shelf_service.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';
part 'shelf_list_back.g.dart';

class ShelfListBack = _ShelfListBack with _$ShelfListBack;

// comand: flutter pub run build_runner build --delete-conflicting-outputs
//flutter packages pub run build_runner clean
abstract class _ShelfListBack with Store {
  final _service = ShelfService();

  @observable
  Future<List<Shelf>>? list;

  @action
  refleshList([dynamic value]) {
    list = _service.findAll();
  }

  _ShelfListBack() {
    refleshList();
  }

  goToForm(BuildContext context, [Shelf? shelf]) {
    Navigator.of(context)
        .pushNamed(Routes.shelfToBookList, arguments: shelf)
        .then(refleshList);
  }

  @action
  dispacheDialogSave(BuildContext context, [Shelf? shelfRef]) {
    Shelf shelf = Shelf();
    if (shelfRef != null) {
      shelf = shelfRef;
    }

    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nova estante'),
        content: FutureBuilder(
          future: list,
          builder: (context, result) {
            if (!result.hasData) {
              return const CircularProgressIndicator();
            }

            List<Shelf> resultData = result.data as List<Shelf>;

            return Form(
              key: _formKey,
              child: TextFormField(
                initialValue: shelf.name,
                validator: (value) {
                  if (resultData
                      .where((e) => e.name == value?.trim() && e.id != shelf.id)
                      .isNotEmpty) {
                    return 'Esta estante já existe.';
                  }

                  if (value == null || value.trim().isEmpty) {
                    return 'Informe um valor válido';
                  }

                  if (value.length > 20) {
                    return 'Nome da estante deve ser menor que 20 caracteres';
                  }
                  return null;
                },
                onSaved: (value) => shelf.name = value,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Informe um nome para sua estante',
                ),
                style: Constants.sdFormText,
                cursorColor: Constants.myGrey,
                textInputAction: TextInputAction.next,
              ),
            );
          },
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: const Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const Padding(padding: EdgeInsets.all(6)),
              ElevatedButton(
                child: const Text('Salvar'),
                onPressed: () {
                  var validate = _formKey.currentState!.validate();
                  _formKey.currentState!.save();
                  if (validate) {
                    save(context, shelf);
                  }
                },
              ),
              const Padding(padding: EdgeInsets.all(6)),
            ],
          ),
        ],
      ),
    );
  }

  Future save(BuildContext context, Shelf shelf) async {
    try {
      await _service.save(shelf);
      CommonService.messageSuccess(context, 'Estante salva com sucesso!');
      Navigator.of(context).pop();
      refleshList();
    } catch (e) {
      CommonService.messageError(context, 'Falha ao salvar estante! $e');
      Navigator.of(context).pop();
    }
  }

  remove(dynamic id, BuildContext context) async {
    try {
      await _service.remove(id);
      refleshList();

      Navigator.of(context).pop();
      CommonService.messageSuccess(context, 'Estante deletada com sucesso!');
    } catch (e) {
      CommonService.messageError(context, 'Falha ao deletar estante! $e!');
      Navigator.of(context).pop();
    }
  }
}
