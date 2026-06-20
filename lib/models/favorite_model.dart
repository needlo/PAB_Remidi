import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:spacenews_core/models/article_model.dart';

class FavoriteModel {
  final String? id;
  final int articleId;
  final String title;
  final String imageUrl;
  final String newsSite;
  final String summary;
  final String publishedAt;
  final String url;
  final String userId;
  final DateTime createdAt;

  const FavoriteModel({
    this.id,
    required this.articleId,
    required this.title,
    required this.imageUrl,
    required this.newsSite,
    required this.summary,
    required this.publishedAt,
    this.url = '',
    required this.userId,
    required this.createdAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    return FavoriteModel(
      id: docId ?? json['id'] as String?,
      articleId: json['articleId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      newsSite: json['newsSite'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      publishedAt: json['publishedAt'] as String? ?? '',
      url: json['url'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : json['createdAt'] is String
              ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
              : DateTime.now(),
    );
  }

  factory FavoriteModel.fromArticle(ArticleModel article, String userId) {
    return FavoriteModel(
      articleId: article.id,
      title: article.title,
      imageUrl: article.imageUrl,
      newsSite: article.newsSite,
      summary: article.summary,
      publishedAt: article.publishedAt,
      url: article.url,
      userId: userId,
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'articleId': articleId,
      'title': title,
      'imageUrl': imageUrl,
      'newsSite': newsSite,
      'summary': summary,
      'publishedAt': publishedAt,
      'url': url,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  @override
  String toString() {
    return 'FavoriteModel(id: $id, articleId: $articleId, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FavoriteModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
