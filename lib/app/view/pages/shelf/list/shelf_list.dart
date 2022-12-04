import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/common/utility/image_parse.dart';
import 'package:projeto_integrador_app/app/domain/entities/shelf.dart';
import 'package:projeto_integrador_app/app/view/components/button_delete_icon.dart';
import 'package:projeto_integrador_app/app/view/components/button_edit_icon.dart';
import 'package:projeto_integrador_app/app/view/components/my_divider.dart';
import 'package:projeto_integrador_app/app/view/pages/shelf/list/shelf_list_back.dart';

class ShelfList extends StatelessWidget {
  ShelfList({Key? key}) : super(key: key);

  final _back = ShelfListBack();

  dynamic _imageBook(Shelf shelf, BuildContext context) {
    String? uri;

    if (shelf.books!.isNotEmpty) {
      var booksFilter =
          shelf.books!.where((e) => e.book!.image != null).toList();
      uri = booksFilter.isNotEmpty ? booksFilter[0].book!.image : null;
    }

    if (uri != null) {
      return CircleAvatar(
          backgroundImage: ImageParse.imageFromBase64String(uri).image);
    }
    // Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      child: Text(
        shelf.name!.substring(0, 1).toUpperCase(),
        style: const TextStyle(color: Constants.myWrite),
      ),
    );
  }

  Text _createTextAux(int length) {
    var myString = ' (' + length.toString() + ') ';

    return Text(myString, style: const TextStyle(color: Constants.myGrey));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return FutureBuilder(
          future: _back.list,
          builder: (context, result) {
            if (!result.hasData) {
              return const CircularProgressIndicator();
            }

            List<Shelf> resultData = result.data as List<Shelf>;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: resultData.length,
                    itemBuilder: (ctx, i) {
                      return Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: [
                                  ButtonEditIcon(
                                    () => _back.dispacheDialogSave(
                                        context, resultData[i]),
                                  ),
                                  ButtonDeleteIcon(
                                    context,
                                    () =>
                                        _back.remove(resultData[i].id, context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () => _back.goToForm(context, resultData[i]),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.only(
                                  bottom: 0,
                                  left: 15,
                                  right: 15,
                                  top: 10,
                                ),
                                leading: _imageBook(resultData[i], context),
                                title: Row(
                                  children: [
                                    Text(
                                      resultData[i].name!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    _createTextAux(resultData[i].books!.length),
                                  ],
                                ),
                              ),
                              const MyDivider(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: FloatingActionButton(
                        onPressed: () => _back.dispacheDialogSave(context),
                        child: const Icon(Icons.add),
                        mini: false,
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}
