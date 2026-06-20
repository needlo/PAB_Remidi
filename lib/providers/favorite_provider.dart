import 'package:flutter/foundation.dart';
import 'package:spacenews_core/models/article_model.dart';
import 'package:spacenews_core/models/favorite_model.dart';
import 'package:spacenews_core/repositories/favorite_repository.dart';

class FavoriteProvider extends ChangeNotifier {
  final FavoriteRepository _favoriteRepository;

  FavoriteProvider({required FavoriteRepository favoriteRepository})
      : _favoriteRepository = favoriteRepository;

  /// Adds an article to the user's favorites.
  Future<void> addFavorite(FavoriteModel fav) async {
    await _favoriteRepository.addFavorite(fav);
    notifyListeners();
  }

  /// Removes a favorite by its Firestore document ID.
  Future<void> removeFavorite(String docId) async {
    await _favoriteRepository.removeFavorite(docId);
    notifyListeners();
  }

  /// Returns a stream of the user's favorite articles.
  Stream<List<FavoriteModel>> getFavorites(String userId) {
    return _favoriteRepository.getFavorites(userId);
  }

  /// Checks whether a specific article is in the user's favorites.
  Future<bool> isFavorite(int articleId, String userId) async {
    return await _favoriteRepository.isFavorite(articleId, userId);
  }

  /// Toggles the favorite state of an article.
  /// If the article is already favorited, it removes it.
  /// If the article is not favorited, it adds it.
  Future<void> toggleFavorite(ArticleModel article, String userId) async {
    final existingFavorite = await _favoriteRepository.getFavoriteByArticleId(
      article.id,
      userId,
    );

    if (existingFavorite != null && existingFavorite.id != null) {
      await removeFavorite(existingFavorite.id!);
    } else {
      final favorite = FavoriteModel.fromArticle(article, userId);
      await addFavorite(favorite);
    }
  }
}
