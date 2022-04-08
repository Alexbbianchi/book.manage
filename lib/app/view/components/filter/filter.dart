import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/view/components/filter/filter_order.dart';
import 'package:projeto_integrador_app/app/view/components/filter/filter_search.dart';
import 'package:projeto_integrador_app/app/view/components/filter/filter_status.dart';

class Filter extends StatefulWidget {
  final dynamic _back;

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
          FilterSearch(widget._back),
          const SizedBox(width: 10),
          FilterStatus(widget._back),
          const SizedBox(width: 10),
          FilterOrder(widget._back),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => widget._back.handlerCleanFilter(),
          ),
        ],
      ),
    );
  }
}
