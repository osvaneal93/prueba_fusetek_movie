

import 'package:prueba_omj/src/data/models/movie_model.dart';
import 'package:prueba_omj/src/data/services/movie_service.dart';

//repositorio para hacer un uso mas eficiente del bloc
class ApiRepository {
  final _provider = MovieService();

  Future<List<MovieModel>> fetchMovieList() {
    return _provider.getMovies();
  }
}

class NetworkError extends Error {}