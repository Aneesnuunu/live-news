import 'package:flutter/material.dart';
import '../model/article.dart';
import '../services/api_service.dart';

class NewsProvider with ChangeNotifier {
  List<Article> _articles = [];
  bool _isLoading = false;
  String _currentCategory = '';  // Empty string means show all articles

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String get currentCategory => _currentCategory;

  // Set current category
  void setCurrentCategory(String category) {
    _currentCategory = category;
    notifyListeners();
  }

  Future<void> fetchArticles(String category) async {
    _isLoading = true;
    notifyListeners();

    if (category == '') {
      // If empty category is passed, fetch all articles
      _articles = await ApiService().fetchArticles('business');  // You can change 'business' to any default category
    } else {
      _currentCategory = category;
      _articles = await ApiService().fetchArticles(category);
    }

    _isLoading = false;
    notifyListeners();
  }
}
