import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/article.dart';

class ApiService {
  final String apiKey = '14764800083a48b797dedeeda0e87499';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> fetchArticles(String category) async {
    final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?country=us&category=$category&apiKey=$apiKey')
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['articles'] as List)
          .map((json) => Article.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
