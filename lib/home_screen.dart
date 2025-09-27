import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rural_learning_app/l10n/app_localizations.dart';
// ignore: unused_import
import 'app_colors.dart';
import 'subject_screen.dart';
import 'chat_screen.dart';
import 'tasks_screen.dart';
// ignore: unused_import
import 'games_screen.dart';
import 'notifiers.dart';
import 'user_model.dart';
import 'learning_lens_screen.dart';

// This helper function now returns the translated time of day
String getGreeting(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final hour = DateTime.now().hour;
  if (hour < 12) return l10n.goodMorning;
  if (hour < 17) return l10n.goodAfternoon;
  return l10n.goodEvening;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeHeader(context),
              const SizedBox(height: 30),
              _buildDailyChallengeCard(context, l10n),
              const SizedBox(height: 30),
              Text(
                l10n.letsGetLearning,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                      shadows: [
                        Shadow(
                          color: Theme.of(context).colorScheme.shadow,
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
              ),
              const SizedBox(height: 20),
              _buildMenuGrid(context, l10n),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SubjectsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 6,
                    shadowColor: Theme.of(context).colorScheme.shadow,
                  ),
                  child: Text(
                    l10n.exploreAllSubjects,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return ValueListenableBuilder<User?>(
      valueListenable: userNotifier,
      builder: (context, user, child) {
        final userName = user?.name ?? 'Friend';
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: isDark ? 0.3 : 0.6),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.greetingUser(getGreeting(context), userName),
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.homeWelcomeSubtitle,
                style: TextStyle(
                  color: theme.colorScheme.primary.withValues(alpha: 0.8),
                  fontSize: 18,
                  shadows: [
                    Shadow(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                      offset: const Offset(1, 1),
                      blurRadius: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDailyChallengeCard(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: isDark ? 0.2 : 0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 40),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.todaysChallenge,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: theme.colorScheme.primary,
                    shadows: [
                      Shadow(
                        color: theme.colorScheme.onSurface.withValues(alpha: isDark ? 0.3 : 0.7),
                        offset: const Offset(2, 2),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
                Text(
                  l10n.todaysChallengeSubtitle,
                  style: TextStyle(
                    fontSize: 18,
                    color: theme.colorScheme.primary.withValues(alpha: 0.8),
                    shadows: [
                      Shadow(
                        color: theme.colorScheme.onSurface.withValues(alpha: isDark ? 0.2 : 0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, size: 22, color: theme.colorScheme.primary),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SubjectsScreen())),
          )
        ],
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context, AppLocalizations l10n) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      childAspectRatio: 1.1,
      children: [
        MenuTile(
          label: l10n.lessons,
          icon: Icons.play_circle_fill_rounded,
          color: Colors.lightBlueAccent,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SubjectsScreen())),
        ),
        MenuTile(
          label: l10n.aiHelper,
          icon: Icons.chat_bubble_rounded,
          color: Colors.purpleAccent,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChatScreen())),
        ),
        MenuTile(
          label: l10n.tasks,
          icon: Icons.assignment_turned_in_rounded,
          color: Colors.lightGreenAccent,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TasksScreen())),
        ),
        MenuTile(
         label: 'Learning Lens', // We can add this to the .arb files later
         icon: Icons.camera_alt_rounded,
         color: Colors.teal,
         onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const LearningLensScreen()),
         ),
        ),
      ],
    );
  }
}

class MenuTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const MenuTile({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withOpacity(0.25),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 16),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
