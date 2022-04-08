import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';

class FilterSearch extends StatefulWidget {

  final dynamic _back;

  const FilterSearch(this._back, {Key? key}) : super(key: key);

  @override
  State<FilterSearch> createState() => _FilterSearchState();
}

class _FilterSearchState extends State<FilterSearch> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            String title = widget._back.filterModel.searchTitle;
            String author = widget._back.filterModel.searchAuthor;
            String publishingCompany =
                widget._back.filterModel.searchPublishingCompany;
            return AlertDialog(
              title: const Text('Filtro por livros'),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SizedBox(
                    width: 200,
                    height: 200,
                    child: Column(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: title,
                            onChanged: (value) => title = value,
                            decoration: const InputDecoration(
                              labelText: 'Título',
                              hintText:
                                  'Informe um título a ser filtrado',
                            ),
                            style: Constants.sdFormText,
                            cursorColor: Constants.myGrey,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: author,
                            onChanged: (value) => author = value,
                            decoration: const InputDecoration(
                              labelText: 'Autor',
                              hintText: 'Informe um autor a ser filtrado',
                            ),
                            style: Constants.sdFormText,
                            cursorColor: Constants.myGrey,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: publishingCompany,
                            onChanged: (value) => publishingCompany = value,
                            decoration: const InputDecoration(
                              labelText: 'Editora',
                              hintText: 'Informe uma editora a ser filtrado',
                            ),
                            style: Constants.sdFormText,
                            cursorColor: Constants.myGrey,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
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
                      child: const Text('Aplicar'),
                      onPressed: () {
                        setState(() {
                          widget._back.filterModel.searchTitle = title;
                          widget._back.filterModel.searchAuthor = author;
                          widget._back.filterModel.searchPublishingCompany = publishingCompany;
                          widget._back.refleshList();
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(6)),
                  ],
                ),
              ],
            );
          },
        );
      },
      child: Row(
        children: [
          Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          Text('Buscar',
              style: TextStyle(color: Theme.of(context).iconTheme.color)),
        ],
      ),
    );
  }
}