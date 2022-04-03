// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf_to_book_list_back.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ShelfToBookListBack on _ShelfToBookListBack, Store {
  final _$listAtom = Atom(name: '_ShelfToBookListBack.list');

  @override
  Future<List<ShelfToBook>>? get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(Future<List<ShelfToBook>>? value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$_ShelfToBookListBackActionController =
      ActionController(name: '_ShelfToBookListBack');

  @override
  dynamic refleshList() {
    final _$actionInfo = _$_ShelfToBookListBackActionController.startAction(
        name: '_ShelfToBookListBack.refleshList');
    try {
      return super.refleshList();
    } finally {
      _$_ShelfToBookListBackActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
list: ${list}
    ''';
  }
}
