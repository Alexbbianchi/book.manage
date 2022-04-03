import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/common/enums/book_status_type.dart';
import 'package:projeto_integrador_app/app/view/components/scroll.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/book_form_back.dart';

class BookNotesFrom extends StatefulWidget {
  final BookFormBack back;
  const BookNotesFrom(this.back, {Key? key}) : super(key: key);

  @override
  _BookNotesFromState createState() => _BookNotesFromState();
}

class _BookNotesFromState extends State<BookNotesFrom> {
  @override
  Widget build(BuildContext context) {
    return Scroll(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _evaluationRating,
            _pagesReadSlider,
            _statusSelect,
            const Padding(padding: EdgeInsets.only(top: 10)),
            _startDateField,
            const Padding(padding: EdgeInsets.only(top: 10)),
            _endDateField,
            const Padding(padding: EdgeInsets.only(top: 10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Anotações',
                  style: TextStyle(fontSize: 16),
                ),
                ..._notesField(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  RatingBar get _evaluationRating {
    return RatingBar.builder(
      initialRating: widget.back.book!.evaluation ?? 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
      onRatingUpdate: (value) {
        setState(() {
          widget.back.book!.evaluation = value;
        });
      },
    );
  }

  Widget get _pagesReadSlider {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 6,
          child: Slider(
            value: widget.back.book!.pagesRead!.toDouble(),
            min: 0,
            max: widget.back.book!.pages!.toDouble(),
            onChanged: (double newSliderValue) {
              setState(
                () {
                  if (newSliderValue.toInt() == 0) {
                    widget.back.book!.status = BookStatusType.notRead;
                  } else if (newSliderValue.toInt() ==
                      widget.back.book!.pages) {
                    widget.back.book!.status = BookStatusType.read;
                  } else {
                    widget.back.book!.status = BookStatusType.reading;
                  }

                  widget.back.book!.pagesRead = newSliderValue.toInt();
                },
              );
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '${widget.back.book!.pagesRead!.round()} páginas',
          ),
        )
      ],
    );
  }

  Widget get _statusSelect {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Status:"),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(BookStatusType.notRead.description),
                value: widget.back.book!.status,
                items: BookStatusType.values
                    .map(
                      (status) => DropdownMenuItem(
                        child: Text(
                          status.description,
                          style: Constants.sdFormText,
                        ),
                        value: status,
                      ),
                    )
                    .toList(),
                onChanged: (dynamic value) {
                  setState(
                    () {
                      if (value == BookStatusType.notRead) {
                        widget.back.book!.pagesRead = 0;
                      }
                      if (value == BookStatusType.read) {
                        widget.back.book!.pagesRead = widget.back.book!.pages;
                      }
                      if (value == BookStatusType.reading &&
                          widget.back.book!.pagesRead == 0) {
                        widget.back.book!.pagesRead = 1;
                      }
                      widget.back.book!.status = value;
                    },
                  );
                },
                // dropdownColor: Constants.myBrown,
              ),
            ),
          ],
        ),
        Divider(thickness: 1, color: Colors.grey.shade700),
      ],
    );
  }

  Widget get _startDateField {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Início: ${CommonService.formattedDate(widget.back.book!.startDate)}",
              style: Constants.sdFormText,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: widget.back.book!.startDate ?? DateTime.now(),
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2222),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      widget.back.book!.startDate = value;
                    });
                  }
                });
              },
              child: const Icon(Icons.date_range),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          color: Colors.grey.shade700,
        ),
      ],
    );
  }

  Widget get _endDateField {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Fim: ${CommonService.formattedDate(widget.back.book!.endDate)}",
              style: Constants.sdFormText,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: widget.back.book!.endDate ?? DateTime.now(),
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2222),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      widget.back.book!.endDate = value;
                    });
                  }
                });
              },
              child: const Icon(Icons.date_range),
            ),
          ],
        ),
        Divider(thickness: 1, color: Colors.grey.shade700),
      ],
    );
  }

  List<Widget> _notesField() {
    List<Widget> friendsTextFieldsList = [];
    if (widget.back.book!.notes == null) {
      setState(() {
        widget.back.book!.notes = [""];
      });
    }
    for (int i = 0; i < widget.back.book!.notes!.length; i++) {
      friendsTextFieldsList.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: widget.back.book!.notes![i] ?? "",
                onChanged: (v) => widget.back.book!.notes![i] = v,
                decoration: const InputDecoration(
                  hintText: 'Insira uma anotação',
                ),
              ),
            ),
            const SizedBox(width: 16),
            _addRemoveButton(i == widget.back.book!.notes!.length - 1, i),
          ],
        ),
      ));
    }
    return List.from(friendsTextFieldsList.reversed);
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          widget.back.book!.notes!.insert(0, null);
        } else {
          widget.back.book!.notes!.removeAt(index);
        }
        setState(() {});
      },
      child: SizedBox(
        width: 30,
        height: 30,
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Constants.myBlack,
        ),
      ),
    );
  }
}
