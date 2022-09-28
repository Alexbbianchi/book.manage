import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/themes/themes.dart';
import 'package:projeto_integrador_app/app/view/home.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/find_api/book_find_api.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/form/book_form.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/view/book_view.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/manage/form/borrowed_form.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/manage/view/borrowed_view.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/form/desire_form.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/view/desire_view.dart';
import 'package:projeto_integrador_app/app/view/pages/shelf/book_list/shelf_to_book_list.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Folha Amarela',
      theme: Themes.bookTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      routes: {
        Routes.home: (context) => const Home(),
        Routes.bookForm: (context) => const BookForm(),
        Routes.bookView: (context) => const BookView(),
        Routes.bookFindApi: (context) => const BookFindAPI(),
        Routes.shelfToBookList: (context) => const ShelfToBookList(),
        Routes.borrowedForm: (context) => const BorrowedForm(),
        Routes.borrowedView: (context) => const BorrowedView(),
        Routes.desireForm: (context) => const DesireForm(),
        Routes.desireView: (context) => const DesireView(),
      },
    );
  }
}
