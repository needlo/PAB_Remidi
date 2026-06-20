import 'package:spacenews_core/models/favorite_model.dart';
import 'package:spacenews_core/services/firestore_service.dart';

class FavoriteRepository {
  final FirestoreService _firestoreService;

  FavoriteRepository({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;

  /// Adds a favorite to Firestore.
  Future<void> addFavorite(FavoriteModel fav) async {
    await _firestoreService.addFavorite(fav);
  }

  /// Removes a favorite from Firestore by document ID.
  Future<void> removeFavorite(String docId) async {
    await _firestoreService.removeFavorite(docId);
  }

  /// Returns a stream of the user's favorite articles, ordered by creation date.
  Stream<List<FavoriteModel>> getFavorites(String userId) {
    return _firestoreService.getFavorites(userId);
  }

  /// Checks whether a specific article is already favorited by the user.
  Future<bool> isFavorite(int articleId, String userId) async {
    final favorite = await _firestoreService.getFavoriteByArticleId(articleId, userId);
    return favorite != null;
  }

  /// Retrieves a favorite by article ID and user ID.
  /// Returns null if the article is not in favorites.
  Future<FavoriteModel?> getFavoriteByArticleId(int articleId, String userId) async {
    return await _firestoreService.getFavoriteByArticleId(articleId, userId);
  }
}
