import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/domain/entities/book.dart';
import 'package:projeto_integrador_app/app/view/components/scroll.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/manage/borrowed_form_back.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';

class BorrowedDetais extends StatefulWidget {
  final BorrowedFormBack? back;

  const BorrowedDetais({Key? key, this.back}) : super(key: key);

  @override
  _BorrowedDetaisState createState() => _BorrowedDetaisState();
}

class _BorrowedDetaisState extends State<BorrowedDetais> {
  @override
  Widget build(BuildContext context) {
    return Scroll(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _bookSelect,
            _nameField,
            const Padding(padding: EdgeInsets.only(top: 20, bottom: 0)),
            _borrowedDateField,
            const Padding(padding: EdgeInsets.only(top: 20, bottom: 0)),
            widget.back!.borrowed!.id != null
                ? _returnedDateField
                : const Padding(padding: EdgeInsets.only(top: 20, bottom: 0)),
          ],
        ),
      ),
    );
  }

  TextFormField get _nameField {
    return TextFormField(
      initialValue: widget.back!.borrowed!.name,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Informe um valor válido';
        }

        if (value.length > 50) {
          return 'Campo deve ter no máximo 50 caracteres';
        }

        return null;
      },
      onSaved: (value) => widget.back!.borrowed!.name = value,
      decoration: const InputDecoration(
        labelText: 'Nome',
        hintText: 'Nome de quem foi emprestado',
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
    );
  }

  Widget get _borrowedDateField {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Data de início: ${CommonService.formattedDate(widget.back!.borrowed!.borrowedDate)}",
              style: Constants.sdFormText,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate:
                      widget.back!.borrowed!.borrowedDate ?? DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2222),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      widget.back!.borrowed!.borrowedDate = value;
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

  Widget get _returnedDateField {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Data de fim: ${CommonService.formattedDate(widget.back!.borrowed!.returnedDate)}",
              style: Constants.sdFormText,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate:
                      widget.back!.borrowed!.returnedDate ?? DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2222),
                ).then((value) {
                  if (value == null) return;

                  if (value.millisecondsSinceEpoch <=
                      widget.back!.borrowed!.borrowedDate!
                          .millisecondsSinceEpoch) {
                    CommonService.messageError(context,
                        "Data final não pode ser inferior que a data de início!");
                    return;
                  }
                  setState(() {
                    widget.back!.borrowed!.returnedDate = value;
                  });
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

  Widget get _bookSelect {
    return FutureBuilder(
      future: widget.back!.findAllBookAvailable(widget.back!.borrowed!.id),
      builder: (context, result) {
        if (!result.hasData) {
          return const CircularProgressIndicator();
        }
        List<Book> resultData = result.data as List<Book>;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Livro:", style: Constants.sdFormText),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: const Text("Selecione um livro"),
                    value: widget.back!.borrowed!.bookId,
                    items: resultData
                        .map(
                          (book) => DropdownMenuItem(
                            child: SizedBox(
                              width: 250,
                              child: Text(
                                book.title!,
                                style: Constants.sdFormText,
                              ),
                            ),
                            value: book.id,
                          ),
                        )
                        .toList(),
                    onChanged: (dynamic value) {
                      setState(() => widget.back!.borrowed!.bookId = value);
                    },
                    // dropdownColor: Constants.myBrown,
                  ),
                )
              ],
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.shade700,
            ),
          ],
        );
      },
    );
  }
}
