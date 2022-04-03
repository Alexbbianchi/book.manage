import 'package:projeto_integrador_app/app/domain/entities/shelf_to_book.dart';

class Shelf {
  int? id;
  String? name;
  List<ShelfToBook>? books;

  Shelf({
    this.id,
    this.name,
    this.books,
  });

  Shelf.fromMap(dynamic obj) {
    id = obj['shelf_id'];
    name = obj['name'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
    };

    return map;
  }
}
