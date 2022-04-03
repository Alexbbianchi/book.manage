// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrowed_list_back.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BorrowedListBack on _BorrowedListBack, Store {
  final _$listAtom = Atom(name: '_BorrowedListBack.list');

  @override
  Future<List<Borrowed>>? get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(Future<List<Borrowed>>? value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$_BorrowedListBackActionController =
      ActionController(name: '_BorrowedListBack');

  @override
  dynamic refleshList([dynamic value]) {
    final _$actionInfo = _$_BorrowedListBackActionController.startAction(
        name: '_BorrowedListBack.refleshList');
    try {
      return super.refleshList(value);
    } finally {
      _$_BorrowedListBackActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
list: ${list}
    ''';
  }
}
