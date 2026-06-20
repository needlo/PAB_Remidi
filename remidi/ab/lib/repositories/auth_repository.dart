import 'package:spacenews_core/models/user_model.dart';
import 'package:spacenews_core/services/auth_service.dart';
import 'package:spacenews_core/services/firestore_service.dart';
import 'package:spacenews_core/services/shared_pref_service.dart';

class AuthRepository {
  final AuthService _authService;
  final FirestoreService _firestoreService;
  final SharedPrefService _sharedPrefService;

  AuthRepository({
    required AuthService authService,
    required FirestoreService firestoreService,
    required SharedPrefService sharedPrefService,
  })  : _authService = authService,
        _firestoreService = firestoreService,
        _sharedPrefService = sharedPrefService;

  /// Returns the current authenticated user's UID, or null if not signed in.
  String? get currentUserId => _authService.currentUserId;

  /// Registers a new user with Firebase Auth and creates a user document in Firestore.
  /// Also saves the session in SharedPreferences.
  Future<void> register(String fullName, String email, String password) async {
    final credential = await _authService.register(email, password);
    final uid = credential.user!.uid;

    final user = UserModel(
      uid: uid,
      fullName: fullName,
      email: email,
      instagram: '',
      profileImage: '',
      createdAt: DateTime.now(),
    );

    await _firestoreService.createUser(user);
    await _sharedPrefService.setLoggedIn(true);
    await _sharedPrefService.setUserId(uid);
  }

  /// Authenticates an existing user with Firebase Auth and saves the session.
  Future<void> login(String email, String password) async {
    final credential = await _authService.login(email, password);
    final uid = credential.user!.uid;

    await _sharedPrefService.setLoggedIn(true);
    await _sharedPrefService.setUserId(uid);
  }

  /// Signs out the current user and clears the session from SharedPreferences.
  Future<void> logout() async {
    await _authService.logout();
    await _sharedPrefService.clear();
  }

  /// Sends a password reset email to the given email address.
  Future<void> resetPassword(String email) async {
    await _authService.resetPassword(email);
  }

  /// Checks if there is a saved login session in SharedPreferences.
  Future<bool> isLoggedIn() async {
    return await _sharedPrefService.isLoggedIn();
  }

  /// Retrieves the user model from Firestore for the given UID.
  Future<UserModel?> getUser(String uid) async {
    return await _firestoreService.getUser(uid);
  }

  /// Updates the user document in Firestore with the provided data.
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _firestoreService.updateUser(uid, data);
  }
}
