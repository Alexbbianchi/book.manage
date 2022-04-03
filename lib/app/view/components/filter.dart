import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/common/enums/filter/sort_filter_type.dart';
import 'package:projeto_integrador_app/app/common/enums/filter/status_filter_type.dart';
import 'package:projeto_integrador_app/app/common/enums/filter/sort_filter_avanced_type.dart';
import 'package:projeto_integrador_app/app/view/pages/book/list/book_list_back.dart';

class Filter extends StatefulWidget {
  final BookListBack _back;

  const Filter(this._back, {Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 10),
      child: Row(
        children: [
          OutlinedButton(
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
                                  onChanged: (value) =>
                                      publishingCompany = value,
                                  decoration: const InputDecoration(
                                    labelText: 'Editora',
                                    hintText:
                                        'Informe uma editora a ser filtrado',
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
                                widget._back.filterModel
                                        .searchPublishingCompany =
                                    publishingCompany;
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
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  StatusFilterType? statusFilter =
                      widget._back.filterModel.status;
                  return AlertDialog(
                    title: const Text('Filtro por status'),
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return SizedBox(
                          width: 200,
                          height: 200,
                          child: Column(
                            children: StatusFilterType.values.map((type) {
                              return Row(
                                children: [
                                  Radio<StatusFilterType>(
                                    value: type,
                                    groupValue: statusFilter,
                                    onChanged: (StatusFilterType? value) {
                                      setState(() {
                                        statusFilter = value;
                                      });
                                    },
                                  ),
                                  Text(type.description),
                                ],
                              );
                            }).toList(),
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
                                widget._back.filterModel.status = statusFilter;
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
                Icon(Icons.filter_alt,
                    color: Theme.of(context).iconTheme.color),
                Text('Filtrar',
                    style: TextStyle(color: Theme.of(context).iconTheme.color)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  SortFilterAvancedType? sortFilterAvanced =
                      widget._back.filterModel.sortAvanced;
                  SortFilterType? sortFilter = widget._back.filterModel.sort;
                  return AlertDialog(
                    title: const Text('Ordenação'),
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return SizedBox(
                          width: 200,
                          height: 280,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Ordenar por:"),
                              Column(
                                children:
                                    SortFilterAvancedType.values.map((type) {
                                  return Row(
                                    children: [
                                      Radio<SortFilterAvancedType>(
                                        value: type,
                                        groupValue: sortFilterAvanced,
                                        onChanged:
                                            (SortFilterAvancedType? value) {
                                          setState(() {
                                            sortFilterAvanced = value;
                                          });
                                        },
                                      ),
                                      Text(type.description),
                                    ],
                                  );
                                }).toList(),
                              ),
                              const Text("Tipo de ordem:"),
                              Column(
                                children: SortFilterType.values.map((type) {
                                  return Row(
                                    children: [
                                      Radio<SortFilterType>(
                                        value: type,
                                        groupValue: sortFilter,
                                        onChanged: (SortFilterType? value) {
                                          setState(() {
                                            sortFilter = value;
                                          });
                                        },
                                      ),
                                      Text(type.description),
                                    ],
                                  );
                                }).toList(),
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
                                widget._back.filterModel.sortAvanced =
                                    sortFilterAvanced;
                                widget._back.filterModel.sort = sortFilter;
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
                Icon(Icons.sort_by_alpha,
                    color: Theme.of(context).iconTheme.color),
                Text('Ordenar',
                    style: TextStyle(color: Theme.of(context).iconTheme.color)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => widget._back.handlerCleanFilter(),
          ),
        ],
      ),
    );
  }
}
