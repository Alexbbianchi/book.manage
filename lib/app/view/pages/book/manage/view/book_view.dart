import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/utility/assets.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/common/utility/image_parse.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/book_form_back.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/view/book_details_view.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/view/book_notes_view.dart';

class BookView extends StatefulWidget {
  const BookView({Key? key}) : super(key: key);

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final back = BookFormBack(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => back.goToForm(context, back.book),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
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
                      child: back.book!.image != null
                          ? ImageParse.imageFromBase64String(back.book!.image!)
                          : Image.asset(ConstantAssets.imgDefault),
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
                            back.book!.title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(back.book!.author!),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "ISBN",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(back.book!.isbn ?? "_"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Constants.myGrey, width: 2.0),
                    ),
                  ),
                ),
                TabBar(
                  controller: _controller,
                  tabs: const <Widget>[
                    Tab(text: "Detalhes"),
                    Tab(text: "Notas"),
                  ],
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  BookDetaisView(back: back),
                  BookNotesView(back: back),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
