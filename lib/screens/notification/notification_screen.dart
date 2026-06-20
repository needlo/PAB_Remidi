import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spacenews_core/widgets/empty_widget.dart';
import 'package:spacenews_core/core/utils/helpers.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.notifications_rounded,
                      color: _secondary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: _textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Stay updated with latest news',
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
            ),

            const SizedBox(height: 12),

            // Notifications List
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('notifications')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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

                  final docs = snapshot.data?.docs ?? [];

                  if (docs.isEmpty) {
                    return const EmptyWidget(
                      icon: Icons.notifications_off_outlined,
                      title: 'No Notifications',
                      subtitle: 'No notifications available',
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      final title = data['title'] ?? 'Notification';
                      final message = data['message'] ?? '';
                      final createdAt = data['createdAt'] as Timestamp?;
                      final dateTime = createdAt?.toDate();

                      return _NotificationCard(
                        title: title,
                        message: message,
                        dateTime: dateTime,
                        index: index,
                        isFirst: index == 0,
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

class _NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final DateTime? dateTime;
  final int index;
  final bool isFirst;

  const _NotificationCard({
    required this.title,
    required this.message,
    this.dateTime,
    required this.index,
    required this.isFirst,
  });

  static const Color _secondary = Color(0xFF2563EB);
  static const Color _accent = Color(0xFF38BDF8);
  static const Color _card = Color(0xFFFFFFFF);
  static const Color _textPrimary = Color(0xFF111827);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _border = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: isFirst ? _secondary.withOpacity(0.04) : _card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isFirst ? _secondary.withOpacity(0.15) : _border,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leading Icon
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _secondary,
                      _accent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                      color: _secondary.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.notifications_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),

              const SizedBox(width: 14),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: _textPrimary,
                              height: 1.3,
                            ),
                          ),
                        ),
                        if (isFirst)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: _secondary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'NEW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (message.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        message,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: _textSecondary,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                    if (dateTime != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 13,
                            color: _textSecondary.withOpacity(0.7),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            Helpers.formatDateTime(dateTime!),
                            style: TextStyle(
                              fontSize: 12,
                              color: _textSecondary.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
