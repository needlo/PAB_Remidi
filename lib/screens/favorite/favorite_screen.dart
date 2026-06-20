import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spacenews_core/providers/favorite_provider.dart';
import 'package:spacenews_core/models/favorite_model.dart';
import 'package:spacenews_core/models/article_model.dart';
import 'package:spacenews_core/widgets/empty_widget.dart';
import 'package:spacenews_core/core/utils/helpers.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  static const Color _primary = Color(0xFF0F172A);
  static const Color _secondary = Color(0xFF2563EB);
  static const Color _accent = Color(0xFF38BDF8);
  static const Color _background = Color(0xFFF8FAFC);
  static const Color _card = Color(0xFFFFFFFF);
  static const Color _textPrimary = Color(0xFF111827);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _border = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          Icons.favorite_rounded,
                          color: Colors.red.shade400,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Favorites',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Your saved articles',
                            style: TextStyle(
                              fontSize: 14,
                              color: _textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Favorites List
            Expanded(
              child: userId == null
                  ? const EmptyWidget(
                      icon: Icons.login_rounded,
                      title: 'Not Logged In',
                      subtitle: 'Please log in to see your favorites',
                    )
                  : StreamBuilder<List<FavoriteModel>>(
                      stream: Provider.of<FavoriteProvider>(context)
                          .getFavorites(userId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: _secondary,
                              strokeWidth: 2.5,
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return EmptyWidget(
                            icon: Icons.error_outline_rounded,
                            title: 'Error Loading',
                            subtitle: snapshot.error.toString(),
                          );
                        }

                        final favorites = snapshot.data ?? [];

                        if (favorites.isEmpty) {
                          return const EmptyWidget(
                            icon: Icons.favorite_border_rounded,
                            title: 'No Favorites Yet',
                            subtitle: 'Articles you save will appear here',
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                          physics: const BouncingScrollPhysics(),
                          itemCount: favorites.length,
                          itemBuilder: (context, index) {
                            final fav = favorites[index];
                            return _FavoriteCard(
                              favorite: fav,
                              userId: userId,
                              index: index,
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final FavoriteModel favorite;
  final String userId;
  final int index;

  const _FavoriteCard({
    required this.favorite,
    required this.userId,
    required this.index,
  });

  static const Color _secondary = Color(0xFF2563EB);
  static const Color _card = Color(0xFFFFFFFF);
  static const Color _textPrimary = Color(0xFF111827);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _border = Color(0xFFE2E8F0);
  static const Color _accent = Color(0xFF38BDF8);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            final article = ArticleModel(
              id: favorite.articleId,
              title: favorite.title,
              summary: favorite.summary,
              imageUrl: favorite.imageUrl,
              newsSite: favorite.newsSite,
              publishedAt: favorite.publishedAt,
              url: favorite.url,
              updatedAt: favorite.publishedAt,
            );
            Navigator.pushNamed(context, '/detail', arguments: article);
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _border, width: 1),
            ),
            child: Row(
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: favorite.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 80,
                      height: 80,
                      color: _border,
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: _secondary,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 80,
                      height: 80,
                      color: _border,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: _textSecondary,
                        size: 24,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        favorite.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: _textPrimary,
                          height: 1.3,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: _secondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              favorite.newsSite,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _secondary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.access_time_rounded,
                            size: 13,
                            color: _textSecondary,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            Helpers.formatDate(favorite.publishedAt),
                            style: const TextStyle(
                              fontSize: 12,
                              color: _textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Delete Button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red.shade400,
                      size: 22,
                    ),
                    onPressed: () {
                      _showDeleteConfirmation(context);
                    },
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.delete_outline_rounded, color: Colors.red, size: 24),
            SizedBox(width: 10),
            Text(
              'Remove Favorite',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to remove this article from your favorites?',
          style: TextStyle(
            fontSize: 15,
            color: _textSecondary,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: _textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (favorite.id == null) return;
              Provider.of<FavoriteProvider>(ctx, listen: false)
                  .removeFavorite(favorite.id!);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Removed from favorites'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: const Color(0xFF0F172A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Remove',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
