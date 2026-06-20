import 'package:spacenews_core/services/api_service.dart';
import 'package:spacenews_core/models/article_model.dart';

class ArticleRepository {
  final ApiService _apiService;

  ArticleRepository({required ApiService apiService}) : _apiService = apiService;

  /// Fetches a list of articles from the API.
  ///
  /// [limit] - The maximum number of articles to return. Defaults to 20.
  /// Returns a list of [ArticleModel] objects.
  /// Throws an [Exception] if the request fails.
  Future<List<ArticleModel>> getArticles({int limit = 20}) async {
    return await _apiService.getArticles(limit: limit);
  }
}
