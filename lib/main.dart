import 'auth/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // NEW: Import for animations

// --- Imports for all the screens that are in separate files ---
import 'subject_screen.dart';
import 'chat_screen.dart';
import 'achievements_screen.dart';
import 'games_screen.dart';
import 'profile_screen.dart';
import 'tasks_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:hive_flutter/hive_flutter.dart'; // Add this import
import 'saved_lesson_model.dart';
import 'quiz_model.dart';


// This is the global state manager for our theme (Dark/Light mode).
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // This line is required
  await Hive.initFlutter();
   // Initialize Hive
  Hive.registerAdapter(SavedLessonAdapter());

  Hive.registerAdapter(SavedQuizAdapter()); 
  Hive.registerAdapter(QuizQuestionAdapter());

  runApp(const RuralLearningApp());
}

class RuralLearningApp extends StatelessWidget {
  const RuralLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'Rural Learning',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // LIGHT THEME
            brightness: Brightness.light,
            scaffoldBackgroundColor: AppColors.bg,
            primaryColor: AppColors.primary,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.bg,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColors.primary),
              titleTextStyle: TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              secondary: AppColors.accent,
            ),
          ),
          darkTheme: ThemeData(
            // DARK THEME
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212),
            primaryColor: AppColors.accent,
            cardColor: const Color(0xFF1E1E1E),
            dividerColor: Colors.white24,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF121212),
              elevation: 0,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            colorScheme: const ColorScheme.dark(
              primary: AppColors.accent,
              secondary: AppColors.primary,
              surface: Color(0xFF1E1E1E),
            ),
          ),
          themeMode: currentMode,
          home: const WelcomeScreen(),
        );
      },
    );
  }
}

class AppColors {
  static const Color primary = Color(0xFF2C5E87);
  static const Color accent = Color(0xFFD29C4A);
  static const Color tile = Color(0xFFF1E5D2);
  static const Color bg = Color(0xFFF8F8F8);
  static const Color muted = Color(0xFF7B7B7B);
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    DashboardScreen(),
    AchievementsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _pages),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events), label: 'Achievements'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ===================================================================
// =================== NEW AND IMPROVED HOME SCREEN ==================
// ===================================================================

// NEW: A helper function for a dynamic greeting based on the time of day
String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) return 'Good Morning';
  if (hour < 17) return 'Good Afternoon';
  return 'Good Evening';
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      // NEW: Applying animations to all the content on the home screen
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SUGGESTION #1: A more dynamic and personal greeting header
          _buildWelcomeHeader(),
          const SizedBox(height: 24),

          // SUGGESTION #2: A "Daily Challenge" card to increase engagement
          _buildDailyChallengeCard(context),
          const SizedBox(height: 24),

          Text("Let's get learning",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          // SUGGESTION #3: A more vibrant and playful menu grid
          _buildMenuGrid(context),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SubjectsScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Explore All Subjects',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms, curve: Curves.easeOut),
    );
  }

  // --- NEW HELPER WIDGETS FOR THE HOME SCREEN ---

  Widget _buildWelcomeHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${getGreeting()}, Salman!',
            style: const TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text("What would you like to learn today?",
              style: TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildDailyChallengeCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: AppColors.accent, size: 32),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Today's Challenge",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Try the 'Math Quiz' in the Games section!",
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 18),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const GamesScreen())),
          )
        ],
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.1, // Adjusted for new design
      children: [
        MenuTile(
          label: 'Lessons',
          icon: Icons.play_circle_fill_rounded,
          color: Colors.blue,
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SubjectsScreen())),
        ),
        MenuTile(
          label: 'Games',
          icon: Icons.sports_esports_rounded,
          color: Colors.orange,
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const GamesScreen())),
        ),
        MenuTile(
          label: 'AI Helper',
          icon: Icons.chat_bubble_rounded,
          color: Colors.purple,
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ChatScreen())),
        ),
        MenuTile(
          label: 'Tasks',
          icon: Icons.assignment_turned_in_rounded,
          color: Colors.green,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const TasksScreen()),
            );
          },
        )
      ],
    );
  }
}

// NEW: This is the colorful, modern tile for the menu grid (Suggestion #3)
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Your DashboardScreen class (remains the same)
class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> subjects = [
    {"icon": Icons.work, "label": "Business"},
    {"icon": Icons.science, "label": "Chemistry"},
    {"icon": Icons.local_hospital, "label": "Medicine"},
    {"icon": Icons.language, "label": "Language"},
    {"icon": Icons.campaign, "label": "Marketing"},
    {"icon": Icons.show_chart, "label": "Analytics"},
  ];

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.0,
        children: subjects.map((subject) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(subject["icon"], size: 40, color: AppColors.primary),
                const SizedBox(height: 10),
                Text(
                  subject["label"],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
