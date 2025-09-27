// lib/profile_screen.dart - FINAL CORRECTED VERSION

import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rural_learning_app/l10n/app_localizations.dart';
import 'notifiers.dart';
import 'offline_lessons_screen.dart';
import 'offline_quizzes_screen.dart';
import 'user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Salman Khan';
  String about = 'Eager to learn and grow.';

  @override
  Widget build(BuildContext context) {
    // Get the localization object for translations
    final l10n = AppLocalizations.of(context)!;

    return ValueListenableBuilder<User?>(
      valueListenable: userNotifier,
      builder: (context, user, child) {
        final displayName = user?.name ?? 'Guest User';
        final userEmail = user?.email ?? 'No email';

        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (context, currentMode, child) {
            final isDarkMode = currentMode == ThemeMode.dark;
            return Scaffold(
              appBar: AppBar(
                // Use the translated title
                title: Text(l10n.profile),
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
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Theme.of(context).cardColor,
                          child: Icon(Icons.person, size: 60, color: Theme.of(context).colorScheme.primary),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.onPrimary, size: 20),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(displayName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(userEmail, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                    const SizedBox(height: 24),

                    // --- User Details Card ---
                    Card(
                      elevation: 2,
                      shadowColor: Theme.of(context).shadowColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _buildInfoTile(
                              icon: Icons.person_outline,
                              title: 'Full Name',
                              subtitle: displayName,
                              onEditPressed: () {
                                _showEditDialog('Edit Full Name', displayName, (value) {
                                  if (user != null) {
                                    userNotifier.value = User(
                                      name: value,
                                      email: user.email,
                                      password: user.password,
                                      createdAt: user.createdAt,
                                    );
                                  }
                                });
                              }
                            ),
                            const Divider(),
                            _buildInfoTile(
                              icon: Icons.email_outlined,
                              title: 'Email',
                              subtitle: userEmail,
                              onEditPressed: () {
                                _showEditDialog('Edit Email', userEmail, (value) {
                                  if (user != null) {
                                    userNotifier.value = User(
                                      name: user.name,
                                      email: value,
                                      password: user.password,
                                      createdAt: user.createdAt,
                                    );
                                  }
                                });
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // --- Settings and Offline Content Card ---
                    Card(
                      elevation: 2,
                      shadowColor: Colors.black.withOpacity(0.05),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.brightness_6_outlined, color: Theme.of(context).colorScheme.primary),
                            title: const Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w500)),
                            trailing: Switch(
                              value: isDarkMode,
                              onChanged: (value) {
                                // This now works because themeNotifier is imported from notifiers.dart
                                themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
                              },
                              activeThumbColor: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: Icon(Icons.language_outlined, color: Theme.of(context).colorScheme.primary),
                            title: Text(l10n.changeLanguage, style: const TextStyle(fontWeight: FontWeight.w500)),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Choose Language'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(title: const Text('English'), onTap: () { localeNotifier.value = const Locale('en'); Navigator.of(context).pop(); }),
                                      ListTile(title: const Text('ଓଡ଼ିଆ (Odia)'), onTap: () { localeNotifier.value = const Locale('or'); Navigator.of(context).pop(); }),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const Divider(),
                          ListTile(
                            leading: Icon(Icons.download_done_outlined, color: Theme.of(context).colorScheme.primary),
                            title: const Text('Offline Lessons', style: TextStyle(fontWeight: FontWeight.w500)),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OfflineLessonsScreen()));
                            },
                          ),
                          const Divider(),
                          ListTile(
                            leading: Icon(Icons.quiz_outlined, color: Theme.of(context).colorScheme.primary),
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
      },
    );
  }

  Widget _buildInfoTile({required IconData icon, required String title, required String subtitle, required VoidCallback onEditPressed}) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
      trailing: IconButton(
        icon: const Icon(Icons.edit_outlined, size: 20),
        onPressed: onEditPressed,
      ),
    );
  }

  void _showEditDialog(String title, String currentValue, ValueChanged<String> onSave) {
    final TextEditingController controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          maxLines: title == 'Edit About Me' ? 3 : 1,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text.trim());
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
