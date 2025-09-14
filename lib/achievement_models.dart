// lib/achievement_models.dart - CORRECTED

import 'package:flutter/material.dart';

// RENAMED the class from Badge to AchievementBadge
class AchievementBadge {
  final String title;
  final IconData icon;
  final Color color;

  const AchievementBadge({
    required this.title,
    required this.icon,
    required this.color,
  });
}

// This class is fine, no changes needed here, but keeping it for completeness.
class LeaderboardEntry {
  final String name;
  final int score;
  final bool isCurrentUser;

  const LeaderboardEntry({
    required this.name,
    required this.score,
    this.isCurrentUser = false,
  });
}