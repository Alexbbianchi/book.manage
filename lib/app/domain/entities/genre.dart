class Genre {
  int? id;
  String? name;

  Genre({
    this.id,
    this.name,
  });

  Genre.fromMap(dynamic obj) {
    id = obj['genre_id'];
    name = obj['name'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
    };

    return map;
  }
}
