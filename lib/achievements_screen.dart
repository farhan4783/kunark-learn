// lib/achievements_screen.dart - CORRECTED

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'achievement_models.dart';

class AchievementsScreen extends StatelessWidget {
  // UPDATED to use the new class name: AchievementBadge
  final List<AchievementBadge> userBadges = const [
    AchievementBadge(
        title: 'Growth Guru', icon: Icons.eco, color: Colors.green),
    AchievementBadge(
        title: 'Pathway Pioneer', icon: Icons.explore, color: Colors.blue),
    AchievementBadge(
        title: 'Perfect Week', icon: Icons.calendar_today, color: Colors.red),
  ];

  // UPDATED here as well
  final List<AchievementBadge> challengesAhead = const [
    AchievementBadge(
        title: 'Quest Seeker', icon: Icons.search, color: Colors.grey),
    AchievementBadge(
        title: 'Skill Master', icon: Icons.star, color: Colors.grey),
    AchievementBadge(
        title: 'Project Pro', icon: Icons.work, color: Colors.grey),
  ];

  final List<LeaderboardEntry> leaderboard = const [
    LeaderboardEntry(name: 'Alex T.', score: 1280),
    LeaderboardEntry(name: 'Maya S.', score: 950),
    LeaderboardEntry(name: 'Leo L.', score: 950),
    LeaderboardEntry(
        name: 'You (Student Name)', score: 800, isCurrentUser: true),
  ];

  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salman Khan'),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
        backgroundColor: AppColors.bg,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeBanner(),
            const SizedBox(height: 24),
            _buildSectionTitle('Your Badges'),
            const SizedBox(height: 16),
            _buildBadgesGrid(userBadges, isLocked: false),
            const SizedBox(height: 24),
            _buildSectionTitle('Challenges Ahead'),
            const SizedBox(height: 16),
            _buildBadgesGrid(challengesAhead, isLocked: true),
            const SizedBox(height: 24),
            _buildLevelProgress(),
            const SizedBox(height: 24),
            _buildLeaderboardCard(),
          ],
        ),
      ),
    );
  }

  // UPDATED to accept a List of the new class name
  Widget _buildBadgesGrid(List<AchievementBadge> badges,
      {required bool isLocked}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: badges
          .map((badge) => _BadgeWidget(badge: badge, isLocked: isLocked))
          .toList(),
    );
  }

  // --- No changes needed in the methods below this line, but included for completeness ---

  Widget _buildWelcomeBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF4A7C9D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to your',
                  style: TextStyle(
                      fontSize: 22, color: Colors.white.withOpacity(0.9)),
                ),
                const Text(
                  'Achievements!',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Icon(Icons.emoji_events, color: Colors.yellow.shade600, size: 80),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
    );
  }

  Widget _buildLevelProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Level 5',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.muted),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const LinearProgressIndicator(
            value: 0.7,
            minHeight: 12,
            backgroundColor: AppColors.tile,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Leaderboard'),
          const SizedBox(height: 12),
          ...leaderboard
              .map((entry) => _LeaderboardTile(entry: entry))
              ,
        ],
      ),
    );
  }
}

// UPDATED to use the new class name
class _BadgeWidget extends StatelessWidget {
  final AchievementBadge badge;
  final bool isLocked;

  const _BadgeWidget({required this.badge, required this.isLocked});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: isLocked ? Colors.grey.shade300 : AppColors.tile,
          child: Icon(
            isLocked ? Icons.lock : badge.icon,
            size: 30,
            color: isLocked ? Colors.white : badge.color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          badge.title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isLocked ? AppColors.muted : AppColors.primary),
        ),
      ],
    );
  }
}

class _LeaderboardTile extends StatelessWidget {
  final LeaderboardEntry entry;

  const _LeaderboardTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: entry.isCurrentUser
            ? AppColors.accent.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Icon(entry.isCurrentUser ? Icons.star : Icons.person,
                color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Text(entry.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Spacer(),
          Text('${entry.score} pts',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.accent)),
        ],
      ),
    );
  }
}
