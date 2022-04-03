enum SortFilterType {
  ascending,
  descending
}

extension SortFilterTypeDescription on SortFilterType {
  // ignore: missing_return
  String get description {
    switch (this) {
      case SortFilterType.ascending:
        return 'Crescente';
      case SortFilterType.descending:
        return 'Decrescente';
    }
  }

  // ignore: missing_return
  String get cod {
    switch (this) {
      case SortFilterType.ascending:
        return 'ascending';
      case SortFilterType.descending:
        return 'descending';
    }
  }
}
