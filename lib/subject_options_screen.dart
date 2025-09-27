import 'package:flutter/material.dart';
import 'package:rural_learning_app/l10n/app_localizations.dart';
import 'app_colors.dart';
import 'subject_lessons_screen.dart';
import 'subject_games_screen.dart';
import 'math_games_screen.dart';

class SubjectOptionsScreen extends StatelessWidget {
  final String subjectName;

  const SubjectOptionsScreen({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName, style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              // Wide screen: side by side
              return SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.lessons,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _OptionCard(
                            label: l10n.lessons,
                            icon: Icons.play_circle_fill_rounded,
                            color: Colors.blue,
                            onTap: () {
                              // Navigate to lessons screen
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SubjectLessonsScreen(subjectName: subjectName),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.games,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _OptionCard(
                            label: l10n.games,
                            icon: Icons.sports_esports_rounded,
                            color: Colors.orange,
                            onTap: () {
                              // Navigate to games screen - use MathGamesScreen for Maths subject
                              if (subjectName == 'Maths') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const MathGamesScreen(),
                                  ),
                                );
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SubjectGamesScreen(subjectName: subjectName),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // Narrow screen: stacked vertically
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.lessons,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _OptionCard(
                      label: l10n.lessons,
                      icon: Icons.play_circle_fill_rounded,
                      color: Colors.blue,
                      onTap: () {
                        // Navigate to lessons screen
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SubjectLessonsScreen(subjectName: subjectName),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.games,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _OptionCard(
                      label: l10n.games,
                      icon: Icons.sports_esports_rounded,
                      color: Colors.orange,
                      onTap: () {
                        // Navigate to games screen - use MathGamesScreen for Maths subject
                        if (subjectName == 'Maths') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MathGamesScreen(),
                            ),
                          );
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SubjectGamesScreen(subjectName: subjectName),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _OptionCard({
    // ignore: unused_element_parameter
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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(width: 20),
            Text(
              label,
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
