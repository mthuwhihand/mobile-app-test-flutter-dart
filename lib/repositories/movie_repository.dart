import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

abstract class IMovieRepository {
  Future<List<Movie>> fetchMovies({required String type});
}

class MovieRepository extends IMovieRepository{
  final String baseUrl = 'https://api.sampleapis.com/movies/';

  @override
  Future<List<Movie>> fetchMovies({required String type}) async{
    final response = await http.get(Uri.parse('$baseUrl$type'));

    if (response.statusCode == 200) {
      List<dynamic> moviesJson = json.decode(response.body);
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}