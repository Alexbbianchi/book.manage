import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:projeto_integrador_app/app/domain/entities/book.dart';
import 'package:projeto_integrador_app/app/view/components/filter.dart';
import 'package:projeto_integrador_app/app/view/components/tile.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';
import 'package:projeto_integrador_app/app/view/components/button_edit_icon.dart';
import 'package:projeto_integrador_app/app/view/components/button_delete_icon.dart';
import 'package:projeto_integrador_app/app/view/pages/book/list/book_list_back.dart';

class BookList extends StatelessWidget {
  BookList({Key? key}) : super(key: key);

  final _back = BookListBack();

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

            List<Book> resultData = result.data as List<Book>;

            return Column(
              children: [
                Filter(_back),
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
                                    () =>
                                        _back.goToForm(context, resultData[i]),
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
                          onTap: () => _back.goToView(context, resultData[i]),
                          child: Tile(
                            image: resultData[i].image,
                            title: resultData[i].title,
                            subtitle: resultData[i].author,
                            infoLeft: Row(
                              children: [
                                const Icon(Icons.library_books),
                                Text(resultData[i].pages.toString()),
                              ],
                            ),
                            infoRigth: resultData[i].publicationDate != null
                                ? Row(
                                    children: [
                                      const Icon(Icons.calendar_today_outlined),
                                      Text(
                                        CommonService.formattedDate(
                                          resultData[i].publicationDate,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Padding(padding: EdgeInsets.all(0)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
