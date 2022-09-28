enum SortFilterType { ascending, descending }

extension SortFilterTypeDescription on SortFilterType {
  String get description {
    switch (this) {
      case SortFilterType.ascending:
        return 'Crescente';
      case SortFilterType.descending:
        return 'Decrescente';
    }
  }

  String get cod {
    switch (this) {
      case SortFilterType.ascending:
        return 'ascending';
      case SortFilterType.descending:
        return 'descending';
    }
  }
}
