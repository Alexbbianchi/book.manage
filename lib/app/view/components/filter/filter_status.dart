import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/enums/filter/status_filter_type.dart';

class FilterStatus extends StatefulWidget {
   final dynamic _back;
  const FilterStatus(this._back, {Key? key}) : super(key: key);

  @override
  State<FilterStatus> createState() => _FilterStatusState();
}

class _FilterStatusState extends State<FilterStatus> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            StatusFilterType? statusFilter = widget._back.filterModel.status;
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
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  statusFilter = type;
                                });
                              },
                              child: Text(type.description),
                            ),
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
    );
  }
}