
import 'package:prueba_omj/src/data/models/movie_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//repositorio para hacer un uso mas eficiente del bloc

class PopularRepo{final url = 'api.themoviedb.org';
  final apiKey = 'a207470fca47d1f7f4fd8f4bcb4ad280';
  final language = 'es-Es';
  static int page = 0;
  bool isLoading = false;
  Future<List<MovieModel>> getPopular() async {
    if (isLoading) return []; 
    isLoading = true;
    page++;
    print('PAGINAAA $page');
    final uri = Uri.https(url, '/3/movie/popular', {
      'api_key': apiKey,
      'language': language,
      'page' : page.toString(),
    });
    final resp =await http.get(uri);
    final decodedData = json.decode(resp.body);
    
   final movies = MovieModelList.fromJsonList(decodedData['results']);
   print(movies.items[0].title);
   isLoading = false;
   return movies.items;
  }} 
class NetworkError extends Error {}