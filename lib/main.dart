import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:spacenews_core/firebase_options.dart';

import 'package:spacenews_core/core/theme/app_theme.dart';
import 'package:spacenews_core/core/routes/app_routes.dart';
import 'package:spacenews_core/core/constants/app_strings.dart';

import 'package:spacenews_core/services/api_service.dart';
import 'package:spacenews_core/services/auth_service.dart';
import 'package:spacenews_core/services/firestore_service.dart';
import 'package:spacenews_core/services/shared_pref_service.dart';

import 'package:spacenews_core/repositories/article_repository.dart';
import 'package:spacenews_core/repositories/auth_repository.dart';
import 'package:spacenews_core/repositories/favorite_repository.dart';

import 'package:spacenews_core/providers/auth_provider.dart' as app_auth;
import 'package:spacenews_core/providers/article_provider.dart';
import 'package:spacenews_core/providers/favorite_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SpaceNewsApp());
}

class SpaceNewsApp extends StatelessWidget {
  const SpaceNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate services
    final apiService = ApiService();
    final authService = AuthService();
    final firestoreService = FirestoreService();
    final sharedPrefService = SharedPrefService();

    // Instantiate repositories
    final articleRepository = ArticleRepository(apiService: apiService);
    final authRepository = AuthRepository(
      authService: authService,
      firestoreService: firestoreService,
      sharedPrefService: sharedPrefService,
    );
    final favoriteRepository = FavoriteRepository(
      firestoreService: firestoreService,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<app_auth.AuthProvider>(
          create: (_) => app_auth.AuthProvider(authRepository: authRepository),
        ),
        ChangeNotifierProvider<ArticleProvider>(
          create: (_) => ArticleProvider(articleRepository: articleRepository),
        ),
        ChangeNotifierProvider<FavoriteProvider>(
          create: (_) => FavoriteProvider(favoriteRepository: favoriteRepository),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
