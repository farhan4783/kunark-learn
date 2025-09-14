// lib/profile_screen.dart - FINAL UPDATED VERSION

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'main.dart' hide AppColors; // To access the themeNotifier
import 'offline_lessons_screen.dart'; // To open the lessons list
import 'offline_quizzes_screen.dart'; // To open the quizzes list

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        final isDarkMode = currentMode == ThemeMode.dark;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- Profile Picture Section ---
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.tile,
                      child: Icon(Icons.person, size: 60, color: AppColors.primary),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primary,
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Salman Khan', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('+91 98765 43210', style: TextStyle(fontSize: 16, color: AppColors.muted)),
                const SizedBox(height: 24),

                // --- User Details Card ---
                Card(
                  elevation: 2,
                  shadowColor: Colors.black.withOpacity(0.1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _buildInfoTile(icon: Icons.person_outline, title: 'Full Name', subtitle: 'Salman Khan'),
                        const Divider(),
                        _buildInfoTile(icon: Icons.phone_outlined, title: 'Phone Number', subtitle: '+91 98765 43210'),
                        const Divider(),
                        _buildInfoTile(icon: Icons.info_outline, title: 'About Me', subtitle: 'Eager to learn and grow.'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // --- Settings and Offline Content Card ---
                Card(
                  elevation: 2,
                  shadowColor: Colors.black.withOpacity(0.1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.brightness_6_outlined, color: AppColors.primary),
                        title: const Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w500)),
                        trailing: Switch(
                          value: isDarkMode,
                          onChanged: (value) {
                            themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
                          },
                          activeColor: AppColors.accent,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.download_done_outlined, color: AppColors.primary),
                        title: const Text('Offline Lessons', style: TextStyle(fontWeight: FontWeight.w500)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OfflineLessonsScreen()));
                        },
                      ),
                      const Divider(), // <<< ADDED
                      ListTile( // <<< ADDED THIS ENTIRE WIDGET
                        leading: const Icon(Icons.quiz_outlined, color: AppColors.primary),
                        title: const Text('Offline Quizzes', style: TextStyle(fontWeight: FontWeight.w500)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OfflineQuizzesScreen()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoTile({required IconData icon, required String title, required String subtitle}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppColors.muted)),
      trailing: IconButton(
        icon: const Icon(Icons.edit_outlined, size: 20),
        onPressed: () {},
      ),
    );
  }
}