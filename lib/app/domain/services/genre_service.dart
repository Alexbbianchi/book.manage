import 'package:projeto_integrador_app/app/domain/entities/genre.dart';
import 'package:projeto_integrador_app/app/domain/repositories/genre_repository.dart';

class GenreService {
  final _genreRepository = GenreRepository();

  Future<List<Genre>> findAll() {
    return _genreRepository.findAll();
  }
}
