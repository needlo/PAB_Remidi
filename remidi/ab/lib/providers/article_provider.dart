import 'package:flutter/foundation.dart';
import 'package:spacenews_core/models/article_model.dart';
import 'package:spacenews_core/repositories/article_repository.dart';

class ArticleProvider extends ChangeNotifier {
  final ArticleRepository _articleRepository;

  List<ArticleModel> _articles = [];
  bool _isLoading = false;
  String? _error;

  ArticleProvider({required ArticleRepository articleRepository})
      : _articleRepository = articleRepository;

  // Getters
  List<ArticleModel> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Returns the first article as the headline, or null if no articles exist.
  ArticleModel? get headlineArticle =>
      _articles.isNotEmpty ? _articles.first : null;

  /// Returns all articles except the headline (first article).
  List<ArticleModel> get remainingArticles =>
      _articles.length > 1 ? _articles.sublist(1) : [];

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Fetches articles from the API with loading state and error handling.
  Future<void> fetchArticles({int limit = 20}) async {
    _setLoading(true);
    _setError(null);
    try {
      _articles = await _articleRepository.getArticles(limit: limit);
      _setLoading(false);
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      _setLoading(false);
    }
  }

  /// Refreshes the article list by fetching fresh data from the API.
  Future<void> refresh() async {
    _setError(null);
    try {
      _articles = await _articleRepository.getArticles();
      notifyListeners();
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      notifyListeners();
    }
  }
}
