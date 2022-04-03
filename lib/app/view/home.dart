import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/common/enums/navigations_types.dart';
import 'package:projeto_integrador_app/app/common/utility/image_parse.dart';
import 'package:projeto_integrador_app/app/domain/entities/book.dart';
import 'package:projeto_integrador_app/app/domain/models/book_api_model.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/view/pages/book/list/book_list.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/list/borrowed_list.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/list/desire_list.dart';
import 'package:projeto_integrador_app/app/view/pages/shelf/list/shelf_list.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _controller;
  int? _indexTop;
  late int _indexBottom;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: NavigationTop.values.length,
      initialIndex: NavigationTop.book.index,
      vsync: this,
    );

    _indexTop = NavigationTop.book.index;
    _indexBottom = NavigationBottom.book.index;
  }

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Folha Amarela',
        ),
        bottom: TabBar(
          isScrollable: true,
          onTap: _onTabTop,
          controller: _controller,
          tabs: const <Widget>[
            Tab(text: "Livro"),
            Tab(text: "Estante"),
            Tab(text: "Emprestado"),
            Tab(text: "Desejo"),
          ],
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          BookList(),
          ShelfList(),
          BorrowedList(),
          DesireList(),
        ],
      ),
      bottomNavigationBar: _indexTop != NavigationTop.shelf.index
          ? BottomNavigationBar(
              currentIndex: _indexBottom,
              onTap: (int i) => _onTabBottom(context, i),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.book_outlined,
                    color: Constants.myDarkGrey,
                    size: 30,
                  ),
                  activeIcon: Icon(
                    Icons.book,
                    color: Constants.myOrange,
                    size: 30,
                  ),
                  tooltip: 'Livro',
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Constants.myDarkGrey,
                    size: 30,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_outline,
                    color: Constants.myDarkGrey,
                    size: 30,
                  ),
                  activeIcon: Icon(
                    Icons.favorite,
                    color: Constants.myOrange,
                    size: 30,
                  ),
                  tooltip: 'Desejo',
                  label: '',
                ),
              ],
            )
          : null,
    );
  }

  void _onSetStateTop(int index) {
    setState(() {
      _indexTop = index;
    });
  }

  void _onSetStateBottom(int index) {
    setState(() {
      _indexBottom = index;
    });
  }

  void _onTabTop(int indexTop) {
    _onSetStateTop(indexTop);

    switch (NavigationTop.values[indexTop]) {
      case NavigationTop.book:
        _onSetStateBottom(NavigationBottom.book.index);
        break;
      case NavigationTop.shelf:
      case NavigationTop.borrowed:
        _onSetStateBottom(NavigationBottom.add.index);
        break;
      case NavigationTop.desire:
        _onSetStateBottom(NavigationBottom.desire.index);
        break;
      default:
        return;
    }
  }

  void _onTabBottom(BuildContext context, int indexBottom) {
    if (indexBottom == NavigationBottom.book.index) {
      _onSetStateTop(NavigationTop.book.index);
      _onSetStateBottom(indexBottom);
      _controller!.index = NavigationTop.book.index;
      return;
    }

    if (indexBottom == NavigationBottom.desire.index) {
      _onSetStateTop(NavigationTop.desire.index);
      _onSetStateBottom(indexBottom);
      _controller!.index = NavigationTop.desire.index;
      return;
    }

    if (indexBottom == NavigationBottom.add.index) {
      switch (NavigationTop.values[_indexTop!]) {
        case NavigationTop.book:
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title:
                  const Text('Adicionar livro', style: TextStyle(fontSize: 22)),
              content: SizedBox(
                width: 120,
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      child: const Text(
                        'Escanear ISBN',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () async {
                        try {
                          await FlutterBarcodeScanner.scanBarcode(
                            '#ff6666',
                            'Cancelar',
                            true,
                            ScanMode.BARCODE,
                          ).then((value) async {
                            if (value != '-1') {
                              if (!await CommonService.validationConnection()) {
                                CommonService.messageError(
                                  context,
                                  "Sem conexão com internet. Direcionando para cadastro manual",
                                );
                                Navigator.of(context)
                                    .pushNamed(
                                      Routes.BOOK_FORM,
                                    )
                                    .then(
                                        (value) => Navigator.of(context).pop());
                              } else {
                                final uri = Uri(
                                  scheme: 'https',
                                  host: 'www.googleapis.com',
                                  path: 'books/v1/volumes',
                                  queryParameters: {
                                    'q': 'isbn:$value',
                                    'key':
                                        'AIzaSyBf2vrFs43KCXYdALCcDGm_EeC-3BpS-5w',
                                  },
                                );

                                final http.Response response =
                                    await http.get(uri);

                                if (response.statusCode != 200) {
                                  CommonService.messageError(
                                      context, 'Erro na requisição.');
                                  return;
                                }

                                var jsonResult =
                                    BookApi.parseFromJsonStr(response.body);

                                if (jsonResult.isEmpty) {
                                  CommonService.messageError(
                                      context, 'ISBN $value não encontrado');
                                  Navigator.of(context)
                                      .pushNamed(Routes.BOOK_FORM,
                                          arguments: Book(isbn: value))
                                      .then((value) =>
                                          Navigator.of(context).pop());
                                } else {
                                  var bookApi = jsonResult[0];

                                  Book newBook = Book(
                                    title: bookApi.title,
                                    author: bookApi.authors,
                                    description: bookApi.description,
                                    pages: bookApi.pageCount,
                                    publicationDate: bookApi.publishedDate,
                                    isbn: value,
                                  );

                                  if (bookApi.thumbnailUrl == null) {
                                    Navigator.of(context)
                                        .pushNamed(
                                          Routes.BOOK_FORM,
                                          arguments: newBook,
                                        )
                                        .then((value) =>
                                            Navigator.of(context).pop());
                                  } else {
                                    ImageParse.networkImageToBase64(
                                            bookApi.thumbnailUrl!)
                                        .then((value) {
                                      newBook.image = value;
                                      Navigator.of(context)
                                          .pushNamed(Routes.BOOK_FORM,
                                              arguments: newBook)
                                          .then((value) =>
                                              Navigator.of(context).pop());
                                    }).catchError((error) {
                                      Navigator.of(context)
                                          .pushNamed(Routes.BOOK_FORM,
                                              arguments: newBook)
                                          .then((value) =>
                                              Navigator.of(context).pop());
                                    });
                                  }
                                }
                              }
                            } else {
                              Navigator.of(context).pop();
                            }
                          });
                        } on PlatformException {
                          CommonService.messageError(
                            context,
                            'Falha ao encontrar código de barra',
                          );
                          Navigator.of(context).pop();
                        }
                        if (!mounted) return;
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'Buscar por título ou ISBN',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(Routes.BOOK_FIND_API)
                            .then((value) => Navigator.of(context).pop());
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'Adicionar manualmente',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(Routes.BOOK_FORM)
                            .then((value) => Navigator.of(context).pop());
                      },
                    ),
                  ],
                ),
              ),
            ),
          );

          return;
        case NavigationTop.borrowed:
          Navigator.of(context).pushNamed(Routes.BORROWED_FORM);
          return;
        case NavigationTop.desire:
          Navigator.of(context).pushNamed(Routes.DESIRE_FORM);
          return;
        default:
          return;
      }
    }
  }
}
