import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieDBApi {
  static const String apiKey = '375a6c79388cbd9948f10cea4920a7d7';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static Future<dynamic> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  static Future<dynamic> getNowPlayingMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load now playing movies');
    }
  }
}
