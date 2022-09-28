enum StatusFilterType {
  all,
  read,
  notRead,
  reading,
}

extension StatusFilterTypeDescription on StatusFilterType? {
  String get description {
    switch (this) {
      case StatusFilterType.all:
        return 'Todos';
      case StatusFilterType.read:
        return 'Lido';
      case StatusFilterType.notRead:
        return 'Não lido';
      case StatusFilterType.reading:
        return 'Lendo';
      default:
        throw "Valor invalido";
    }
  }

  String get cod {
    switch (this) {
      case StatusFilterType.all:
        return 'all';
      case StatusFilterType.read:
        return 'read';
      case StatusFilterType.notRead:
        return 'notRead';
      case StatusFilterType.reading:
        return 'reading';
      default:
        throw "Valor invalido";
    }
  }
}
