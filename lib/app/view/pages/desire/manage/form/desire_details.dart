import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:projeto_integrador_app/app/common/utility/assets.dart';
import 'package:projeto_integrador_app/app/common/enums/book_format_type.dart';
import 'package:projeto_integrador_app/app/common/enums/book_language_type.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/common/utility/image_parse.dart';
import 'package:projeto_integrador_app/app/domain/entities/genre.dart';
import 'package:projeto_integrador_app/app/view/components/scroll.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/desire_form_back.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';

class DesireDetais extends StatefulWidget {
  final DesireFormBack back;

  const DesireDetais(this.back, {Key? key}) : super(key: key);

  @override
  _DesireDetaisState createState() => _DesireDetaisState();
}

class _DesireDetaisState extends State<DesireDetais> {
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if (widget.back.book!.notes == null) {
      setState(() {
        widget.back.book!.notes = [''];
      });
    }

    return FutureBuilder(
      future: widget.back.findAllISBN(),
      builder: (context, result) {
        if (!result.hasData) {
          return const CircularProgressIndicator();
        }

        List<String> isbns = result.data as List<String>;

        return Scroll(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _titleField,
                _authorField,
                _sourceBookSection(isbns),
                _genreField,
                const Padding(padding: EdgeInsets.only(top: 20, bottom: 0)),
                _publicationDateField,
                _pagesField,
                _languageSelect,
              ],
            ),
          ),
        );
      },
    );
  }

  TextFormField get _titleField {
    return TextFormField(
      initialValue: widget.back.book!.title,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Informe um valor válido';
        }

        if (value.length > 100) {
          return 'Campo deve ter no máximo 100 caracteres';
        }

        return null;
      },
      onSaved: (value) => widget.back.book!.title = value,
      decoration: const InputDecoration(
        labelText: 'Título',
        hintText: 'Titulo do livro',
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
    );
  }

  TextFormField get _authorField {
    return TextFormField(
      initialValue: widget.back.book!.author,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Informe um valor válido';
        }

        if (value.length > 100) {
          return 'Campo deve ter no máximo 100 caracteres';
        }

        return null;
      },
      onSaved: (value) => widget.back.book!.author = value,
      decoration: const InputDecoration(
        labelText: 'Autor(a)',
        hintText: 'Nome do autor(a)',
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _sourceBookSection(List<String> isbns) {
    return Row(
      children: [
        _imagePicker(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _publishingCompanyField,
                _isbnField(isbns),
                _formatoSelect,
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _imagePicker() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey.shade400, width: 2),
      // ),
      child: GestureDetector(
        onTap: _showDialog,
        child: widget.back.book!.image != null
            ? ImageParse.imageFromBase64String(widget.back.book!.image!)
            : Image.asset(ConstantAssets.imgDefault),
      ),
    );
  }

  void _showDialog() {
    showDialog<String>(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('Alterar foto'),
        alignment: Alignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Icon(Icons.photo_camera),
                onPressed: () async => _pickImageFromCamera(),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                child: const Icon(Icons.photo),
                onPressed: () async => _pickImageFromGallery(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => widget.back.book!.image =
          ImageParse.base64String(File(pickedFile.path).readAsBytesSync()));
    }
    Navigator.pop(context);
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => widget.back.book!.image =
          ImageParse.base64String(File(pickedFile.path).readAsBytesSync()));
    }

    Navigator.pop(context);
  }

  TextFormField get _publishingCompanyField {
    return TextFormField(
      initialValue: widget.back.book!.publishingCompany,
      validator: (value) {
        if (value!.length > 100) {
          return 'Campo deve ter no máximo 100 caracteres';
        }
        return null;
      },
      onSaved: (value) => widget.back.book!.publishingCompany = value,
      decoration: const InputDecoration(
        labelText: 'Editora',
        hintText: 'Nome da editora',
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
    );
  }

  TextFormField _isbnField(List<String> isbns) {
    return TextFormField(
      initialValue: widget.back.book!.isbn,
      validator: (value) {
        if (isbns.where((element) => element == value).isNotEmpty) {
          return 'ISBN não pode ser repetido';
        }
        if (value!.length > 20) {
          return 'Campo deve ter no máximo 20 caracteres';
        }
        return null;
      },
      onSaved: (value) => widget.back.book!.isbn = value != "" ? value : null,
      decoration: const InputDecoration(
        labelText: 'ISBN',
        hintText: 'Informe o valor do ISBN',
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
    );
  }

  Widget get _formatoSelect {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Formato:"),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(BookFormatType.pocketBook.description),
                value: widget.back.book!.format,
                items: BookFormatType.values
                    .map(
                      (format) => DropdownMenuItem(
                        child: Text(
                          format.description,
                          style: Constants.sdFormText,
                        ),
                        value: format,
                      ),
                    )
                    .toList(),
                onChanged: (dynamic value) {
                  setState(() {
                    widget.back.book!.format = value;
                  });
                },
                // dropdownColor: Constants.myBrown,
              ),
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

  Widget get _genreField {
    return FutureBuilder(
      future: widget.back.findAllGenre(),
      builder: (context, result) {
        if (!result.hasData) {
          return const CircularProgressIndicator();
        }
        List<Genre> resultData = result.data as List<Genre>;

        return MultiSelectDialogField(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.8,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          initialValue: widget.back.book!.genres,
          buttonIcon: Icon(
            Icons.arrow_drop_down,
            color: Colors.grey.shade700,
          ),
          searchable: true,
          searchHint: 'Pesquisar',
          buttonText: const Text('Gênero:', textAlign: TextAlign.left),
          cancelText: const Text('Cancelar'),
          confirmText: const Text(
            'Aplicar',
            style: TextStyle(color: Constants.myOrange),
          ),
          title: const Text('Gênero'),
          closeSearchIcon: const Icon(Icons.search_off),
          onSaved: (value) => widget.back.book!.genres = value as List<int?>?,
          items: resultData
              .map((genre) => MultiSelectItem(genre.id, genre.name!))
              .toList(),
          listType: MultiSelectListType.CHIP,
          onConfirm: (value) {
            setState(() => widget.back.book!.genres = value as List<int?>?);
          },
        );
      },
    );
  }

  Widget get _publicationDateField {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Publicação: ${CommonService.formattedDate(widget.back.book!.publicationDate)}",
              style: Constants.sdFormText,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate:
                      widget.back.book!.publicationDate ?? DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2222),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      widget.back.book!.publicationDate = value;
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

  TextFormField get _pagesField {
    return TextFormField(
      initialValue: widget.back.book!.pages.toString(),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Informe um valor válido';
        }

        if (int.parse(value) < 0) {
          return 'Número de páginas não pode ser negativas';
        }
        return null;
      },
      onSaved: (value) =>
          widget.back.book!.pages = value != "" ? int.parse(value!) : 0,
      decoration: const InputDecoration(
        labelText: 'Páginas',
        hintText: 'Informe a quantidade de páginas',
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
    );
  }

  Widget get _languageSelect {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Idioma:"),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(BookLanguageType.portuguese.description),
                value: widget.back.book!.language,
                items: BookLanguageType.values
                    .map((language) => DropdownMenuItem(
                          child: Text(
                            language.description,
                            style: Constants.sdFormText,
                          ),
                          value: language,
                        ))
                    .toList(),
                onChanged: (dynamic value) {
                  setState(() {
                    widget.back.book!.language = value;
                  });
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
  }
}
