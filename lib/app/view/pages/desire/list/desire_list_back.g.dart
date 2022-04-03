// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desire_list_back.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DesireListBack on _DesireListBack, Store {
  final _$listAtom = Atom(name: '_DesireListBack.list');

  @override
  Future<List<Book>>? get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(Future<List<Book>>? value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$_DesireListBackActionController =
      ActionController(name: '_DesireListBack');

  @override
  dynamic refleshList([dynamic value]) {
    final _$actionInfo = _$_DesireListBackActionController.startAction(
        name: '_DesireListBack.refleshList');
    try {
      return super.refleshList(value);
    } finally {
      _$_DesireListBackActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
list: ${list}
    ''';
  }
}
