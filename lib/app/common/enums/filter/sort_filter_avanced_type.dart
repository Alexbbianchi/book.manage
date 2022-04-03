enum SortFilterAvancedType {
  title,
  author,
  publishingCompany,
}

extension SortFilterAvancedTypeDescription on SortFilterAvancedType? {
  String get description {
    switch (this) {
      case SortFilterAvancedType.title:
        return 'Título';
      case SortFilterAvancedType.author:
        return 'Autor';
      case SortFilterAvancedType.publishingCompany:
        return 'Editora';
      default:
        throw "Valor invalido";
    }
  }

  // ignore: missing_return
  String get cod {
    switch (this) {
      case SortFilterAvancedType.title:
        return 'title';
      case SortFilterAvancedType.author:
        return 'author';
      case SortFilterAvancedType.publishingCompany:
        return 'publishing_company';
      default:
        throw "Valor invalido";
    }
  }
}
