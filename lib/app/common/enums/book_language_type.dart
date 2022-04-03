enum BookLanguageType {
  portuguese,
  inglish,
  spanish,
  french,
  mandarin,
  chinese,
  japanese,
  other,
}

extension BookLanguageTypeDescription on BookLanguageType? {
  // ignore: missing_return
  String get description {
    switch (this) {
      case BookLanguageType.portuguese:
        return 'Português';
      case BookLanguageType.inglish:
        return 'Inglês';
      case BookLanguageType.spanish:
        return 'Espanhol';
      case BookLanguageType.french:
        return 'Francês';
      case BookLanguageType.mandarin:
        return 'Mandarim';
      case BookLanguageType.chinese:
        return 'Chinês';
      case BookLanguageType.japanese:
        return 'Japones';
      case BookLanguageType.other:
        return 'Outro';
      default:
        throw "Valor invalido";
    }
  }

  // ignore: missing_return
  String get cod {
    switch (this) {
      case BookLanguageType.portuguese:
        return 'portuguese';
      case BookLanguageType.inglish:
        return 'inglish';
      case BookLanguageType.spanish:
        return 'spanish';
      case BookLanguageType.french:
        return 'french';
      case BookLanguageType.mandarin:
        return 'mandarin';
      case BookLanguageType.chinese:
        return 'chinese';
      case BookLanguageType.japanese:
        return 'japanese';
      case BookLanguageType.other:
        return 'other';
      default:
        throw "Valor invalido";
    }
  }
}
