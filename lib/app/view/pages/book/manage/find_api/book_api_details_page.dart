import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/utility/image_parse.dart';
import 'package:projeto_integrador_app/app/domain/entities/book.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/view/components/scroll.dart';
import 'package:projeto_integrador_app/app/domain/models/book_api_model.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';

class BookApiDetailsPage extends StatelessWidget {
  final BookApi _book;

  const BookApiDetailsPage(this._book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Visualizar livro"),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_add_sharp),
            onPressed: () => prepareObject(context, _book),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scroll(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                      child: Hero(
                        tag: _book.id!,
                        child: _book.thumbnail,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            _book.title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(_book.authors),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                _book.description,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Páginas",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(_book.pageCount.toString()),
                      ],
                    ),
                  ),
                  _book.publishedDate != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Data de Publicação",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                CommonService.formattedDate(
                                  _book.publishedDate,
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
        ),
      ),
    );
  }

  void prepareObject(BuildContext context, BookApi bookApi) {
    Book newBook = Book(
      title: bookApi.title,
      author: bookApi.authors,
      description: bookApi.description,
      pages: bookApi.pageCount,
      publicationDate: bookApi.publishedDate,
    );

    if (bookApi.thumbnailUrl == null) {
      goToBookForm(context, newBook);
    }

    ImageParse.networkImageToBase64(bookApi.thumbnailUrl!).then((value) {
      newBook.image = value;
      goToBookForm(context, newBook);
    }).catchError(
      (error) {
        goToBookForm(context, newBook);
      } 
    );
  }

  void goToBookForm(BuildContext context, Book book) {
    Navigator.of(context).pushReplacementNamed(
      Routes.BOOK_FORM,
      arguments: book,
    );
  }
}
