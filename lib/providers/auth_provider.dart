import 'package:flutter/foundation.dart';
import 'package:spacenews_core/models/user_model.dart';
import 'package:spacenews_core/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  bool _isLoading = false;
  String? _error;
  UserModel? _user;

  AuthProvider({required AuthRepository authRepository})
      : _authRepository = authRepository;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  UserModel? get user => _user;
  String? get currentUserId => _authRepository.currentUserId;

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

  /// Registers a new user and creates a Firestore profile.
  Future<bool> register(String fullName, String email, String password) async {
    _setLoading(true);
    _setError(null);
    try {
      await _authRepository.register(fullName, email, password);
      await loadUser();
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(_mapAuthError(e));
      _setLoading(false);
      return false;
    }
  }

  /// Authenticates an existing user.
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _setError(null);
    try {
      await _authRepository.login(email, password);
      await loadUser();
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(_mapAuthError(e));
      _setLoading(false);
      return false;
    }
  }

  /// Signs out the current user and clears session data.
  Future<void> logout() async {
    _setLoading(true);
    _setError(null);
    try {
      await _authRepository.logout();
      _user = null;
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  /// Sends a password reset email.
  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _setError(null);
    try {
      await _authRepository.resetPassword(email);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(_mapAuthError(e));
      _setLoading(false);
      return false;
    }
  }

  /// Checks if the user has an active session.
  Future<bool> isLoggedIn() async {
    return await _authRepository.isLoggedIn();
  }

  /// Loads the current user's profile from Firestore.
  Future<void> loadUser() async {
    final uid = _authRepository.currentUserId;
    if (uid != null) {
      _user = await _authRepository.getUser(uid);
      notifyListeners();
    }
  }

  /// Updates the user's profile in Firestore.
  Future<bool> updateProfile({
    required String fullName,
    required String instagram,
    required String profileImage,
  }) async {
    _setLoading(true);
    _setError(null);
    try {
      final uid = _authRepository.currentUserId;
      if (uid == null) {
        _setError('User not authenticated.');
        _setLoading(false);
        return false;
      }

      final data = <String, dynamic>{
        'fullName': fullName,
        'instagram': instagram,
        'profileImage': profileImage,
      };

      await _authRepository.updateUser(uid, data);

      // Update the local user model
      if (_user != null) {
        _user = _user!.copyWith(
          fullName: fullName,
          instagram: instagram,
          profileImage: profileImage,
        );
      }

      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  /// Maps Firebase Auth error codes to user-friendly messages.
  String _mapAuthError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('user-not-found') ||
        errorString.contains('no user record')) {
      return 'No account found with this email address.';
    } else if (errorString.contains('wrong-password') ||
        errorString.contains('invalid-credential')) {
      return 'Incorrect password. Please try again.';
    } else if (errorString.contains('email-already-in-use')) {
      return 'An account already exists with this email address.';
    } else if (errorString.contains('weak-password')) {
      return 'Password is too weak. Use at least 6 characters.';
    } else if (errorString.contains('invalid-email')) {
      return 'Please enter a valid email address.';
    } else if (errorString.contains('too-many-requests')) {
      return 'Too many failed attempts. Please try again later.';
    } else if (errorString.contains('network')) {
      return 'Network error. Please check your internet connection.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
