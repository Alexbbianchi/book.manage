enum BookItemType {
  bought,
  desire,
}

extension BookItemTypeDescription on BookItemType? {
  String get description {
    switch (this) {
      case BookItemType.bought:
        return 'Comprado';
      case BookItemType.desire:
        return 'Desejo';
      default:
        throw "Valor invalido";
    }
  }

  String get cod {
    switch (this) {
      case BookItemType.bought:
        return 'bought';
      case BookItemType.desire:
        return 'desire';
      default:
        throw "Valor invalido";
    }
  }
}
