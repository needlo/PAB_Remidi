import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spacenews_core/models/user_model.dart';
import 'package:spacenews_core/models/favorite_model.dart';
import 'package:spacenews_core/models/notification_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  CollectionReference<Map<String, dynamic>> get _favoritesCollection =>
      _firestore.collection('favorites');

  CollectionReference<Map<String, dynamic>> get _notificationsCollection =>
      _firestore.collection('notifications');

  // ==================== User Operations ====================

  /// Creates a new user document in Firestore.
  Future<void> createUser(UserModel user) async {
    await _usersCollection.doc(user.uid).set(user.toJson());
  }

  /// Retrieves a user document by UID.
  Future<UserModel?> getUser(String uid) async {
    final doc = await _usersCollection.doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  /// Updates a user document with the provided data.
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _usersCollection.doc(uid).update(data);
  }

  // ==================== Favorite Operations ====================

  /// Adds a new favorite document to Firestore.
  Future<void> addFavorite(FavoriteModel fav) async {
    await _favoritesCollection.add(fav.toJson());
  }

  /// Removes a favorite document by its document ID.
  Future<void> removeFavorite(String docId) async {
    await _favoritesCollection.doc(docId).delete();
  }

  /// Returns a stream of favorites for a given user, ordered by creation date descending.
  Stream<List<FavoriteModel>> getFavorites(String userId) {
    return _favoritesCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return FavoriteModel.fromJson(doc.data(), docId: doc.id);
      }).toList();
    });
  }

  /// Retrieves a specific favorite by article ID and user ID.
  Future<FavoriteModel?> getFavoriteByArticleId(int articleId, String userId) async {
    final snapshot = await _favoritesCollection
        .where('articleId', isEqualTo: articleId)
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      return FavoriteModel.fromJson(doc.data(), docId: doc.id);
    }
    return null;
  }

  // ==================== Notification Operations ====================

  /// Returns a stream of notifications, ordered by creation date descending.
  Stream<List<NotificationModel>> getNotifications() {
    return _notificationsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return NotificationModel.fromJson(doc.data(), docId: doc.id);
      }).toList();
    });
  }
}
