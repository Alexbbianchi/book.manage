import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/enums/filter/sort_filter_avanced_type.dart';
import 'package:projeto_integrador_app/app/common/enums/filter/sort_filter_type.dart';

class FilterOrder extends StatefulWidget {
  final dynamic _back;
  const FilterOrder(this._back, {Key? key}) : super(key: key);

  @override
  State<FilterOrder> createState() => _FilterOrderState();
}

class _FilterOrderState extends State<FilterOrder> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            SortFilterAvancedType? sortFilterAvanced = widget._back.filterModel.sortAvanced;
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
                          children: SortFilterAvancedType.values.map((type) {
                            return Row(
                              children: [
                                Radio<SortFilterAvancedType>(
                                  value: type,
                                  groupValue: sortFilterAvanced,
                                  onChanged: (SortFilterAvancedType? value) {
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
                          widget._back.filterModel.sortAvanced = sortFilterAvanced;
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
          Icon(
            Icons.sort_by_alpha,
            color: Theme.of(context).iconTheme.color,
          ),
          Text(
            'Ordenar',
            style: TextStyle(color: Theme.of(context).iconTheme.color),
          ),
        ],
      ),
    );
  }
}