//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../model/article.dart';
//
// class NewsService {
//   static Future<List<Article>> fetchArticles(String category, {int page = 1}) async {
//     final apiKey = 'YOUR_API_KEY'; // Replace with your API key
//     final url = Uri.parse(
//         'https://newsapi.org/v2/top-headlines?category=$category&page=$page&apiKey=$apiKey');
//
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (data['articles'] != null) {
//         return (data['articles'] as List).map((articleData) => Article.fromJson(articleData)).toList();
//       }
//     } else {
//       throw Exception('Failed to load news');
//     }
//     return [];
//   }
// }
