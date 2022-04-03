import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/view/components/my_divider.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/find_api/book_api_details_page.dart';
import 'package:projeto_integrador_app/app/domain/models/book_api_model.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';

class BookFindAPI extends StatefulWidget {
  const BookFindAPI({Key? key}) : super(key: key);

  @override
  State<BookFindAPI> createState() => _BookFindAPIState();
}

class _BookFindAPIState extends State<BookFindAPI> {
  String? textFind;
  List<BookApi> _listBookApi = [];
  bool _pending = false;

  @override
  void initState() {
    super.initState();
    textFind = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pesquisar livro"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: textFind,
                    onChanged: (v) => setState(() => textFind = v),
                    decoration: const InputDecoration(
                      labelText: 'Título ou ISBN',
                      hintText: 'Insira um titulo ou ISBN',
                    ),
                    style: Constants.sdFormText,
                    cursorColor: Constants.myGrey,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  child: ElevatedButton(
                    child: const Text('Pesquisar'),
                    onPressed: _pending ? null : () => _search(textFind),
                  ),
                ),
              ],
            ),
          ),
          _listBookApi.isNotEmpty || _listBookApi.isEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _listBookApi.length,
                    itemBuilder: (ctx, i) => _bookToListTile(_listBookApi[i]),
                  ),
                )
              : const Text('Pesquisar')
        ],
      ),
    );
  }

  Widget _bookToListTile(BookApi bookApi) {
    return Column(
      children: [
        ListTile(
          title: Text(bookApi.title!),
          subtitle: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(bookApi.authors),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        const Icon(Icons.library_books),
                        Text(bookApi.pageCount.toString()),
                      ],
                    ),
                  ),
                  bookApi.publishedDate != null
                      ? Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined),
                              Text(
                                CommonService.formattedDate(
                                  bookApi.publishedDate,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Padding(padding: EdgeInsets.all(0)),
                ],
              ),
            ],
          ),
          leading: Hero(tag: bookApi.id!, child: bookApi.thumbnail),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => BookApiDetailsPage(bookApi)),
          ),
        ),
        const MyDivider(),
      ],
    );
  }

  Future<List<BookApi>> _getBooksList(String? query) async {
    final uri = Uri(
      scheme: 'https',
      host: 'www.googleapis.com',
      path: 'books/v1/volumes',
      queryParameters: {
        'q': query,
        'maxResults': '40',
      },
    );
    final http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return BookApi.parseFromJsonStr(response.body);
    }
    throw response;
  }

  Future<void> _search(String? query) async {
    setState(() => _pending = true);
    try {
      if (!await CommonService.validationConnection()) {
        CommonService.messageError(
          context,
          "Sem conexão com internet. Direcionando para cadastro manual",
        );
        Navigator.of(context)
            .pushNamed(
              Routes.BOOK_FORM,
            )
            .then((value) => Navigator.of(context).pop());
      } else {
        _listBookApi = await _getBooksList(query);
        if (mounted) {
          CommonService.messageSuccess(
            context,
            'Sucesso!!! Encontrado ${_listBookApi.length} livros.',
          );
        }
      }
    } catch (e) {
      CommonService.messageError(
        context,
        'Error $e. O servidor não pode processar a sua solicitação. Tente novamente mais tarde!',
      );
    }
    setState(() => _pending = false);
  }
}
