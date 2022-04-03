// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf_list_back.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ShelfListBack on _ShelfListBack, Store {
  final _$listAtom = Atom(name: '_ShelfListBack.list');

  @override
  Future<List<Shelf>>? get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(Future<List<Shelf>>? value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$_ShelfListBackActionController =
      ActionController(name: '_ShelfListBack');

  @override
  dynamic refleshList([dynamic value]) {
    final _$actionInfo = _$_ShelfListBackActionController.startAction(
        name: '_ShelfListBack.refleshList');
    try {
      return super.refleshList(value);
    } finally {
      _$_ShelfListBackActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispacheDialogSave(BuildContext context, [Shelf? shelfRef]) {
    final _$actionInfo = _$_ShelfListBackActionController.startAction(
        name: '_ShelfListBack.dispacheDialogSave');
    try {
      return super.dispacheDialogSave(context, shelfRef);
    } finally {
      _$_ShelfListBackActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
list: ${list}
    ''';
  }
}
