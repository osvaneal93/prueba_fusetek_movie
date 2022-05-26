import 'dart:convert';

import 'package:prueba_omj/src/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

//Nuestro servicio que hace las peticiones a nuestra api, contiene las credenciales necesarias para
//llevar a cabo la recoleccion de informacion

class MovieService {
  final url = 'api.themoviedb.org';
  final apiKey = 'a207470fca47d1f7f4fd8f4bcb4ad280';
  final language = 'es-Es';
  
    int page =0;
  bool _loading = false;
  List <MovieModel> movieList = [];



  Future<List<MovieModel>> getMovies() async {
    final uri = Uri.https(url, '/3/movie/now_playing', {
      'api_key': apiKey,
      'language': language,
    });
    final resp =await http.get(uri);
    final decodedData = json.decode(resp.body);
    
   final movies = MovieModelList.fromJsonList(decodedData['results']);
   print(movies.items[0].title);
   return movies.items;
  }
}