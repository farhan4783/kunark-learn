import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: unused_import
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rural_learning_app/l10n/app_localizations.dart';
import 'home_screen.dart';
import 'dashboard/adapted_dashboard_screen.dart';
import 'achievements_screen.dart';
import 'profile_screen.dart';
import 'auth/welcome_screen.dart';
import 'app_colors.dart';
import 'notifiers.dart';
import 'saved_lesson_model.dart';
import 'user_model.dart';

Map<String, String> appEnv = {};

final ValueNotifier<bool> hiveInitNotifier = ValueNotifier<bool>(true);


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Load .env from assets since dotenv.load() doesn't work in APK
    final envContent = await rootBundle.loadString('assets/.env');
    final lines = envContent.split('\n');
    for (var line in lines) {
      final trimmed = line.trim();
      if (trimmed.isNotEmpty && trimmed.contains('=')) {
        final index = trimmed.indexOf('=');
        final key = trimmed.substring(0, index).trim();
        final value = trimmed.substring(index + 1).trim();
        appEnv[key] = value;
      }
    }
  } catch (e) {
    print('Dotenv load error: $e');
    // Continue without env vars if needed
  }

  try {
    await Hive.initFlutter();
    Hive.registerAdapter(SavedLessonAdapter());
    Hive.registerAdapter(UserAdapter());
    hiveInitNotifier.value = true;
  } catch (e) {
    print('Hive init error: $e');
    hiveInitNotifier.value = false;
  }

  // Always attempt user storage init, even if Hive init had issues (defensive)
  try {
    await initializeUserStorage();
  } catch (e) {
    print('User storage init error: $e');
    // Don't fail app start; rely on lazy init in auth
  }

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (context, themeMode, child) {
            return ValueListenableBuilder<bool>(
              valueListenable: hiveInitNotifier,
              builder: (context, initSuccess, child) {
                return MaterialApp(
                  title: 'Rural Learning App',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.primary,
                      secondary: AppColors.accent,
                      surface: AppColors.tile,
                      onPrimary: Colors.white,
                      onSecondary: Colors.white,
                      onSurface: AppColors.primary,
                    ),
                    scaffoldBackgroundColor: AppColors.bg,
                    cardColor: AppColors.tile,
                    textTheme: const TextTheme(
                      bodyLarge: TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
                      bodyMedium: TextStyle(color: Color.fromARGB(255, 2, 41, 73)),
                    ),
                  ),
                  darkTheme: ThemeData(
                    colorScheme: const ColorScheme.dark(
                      primary: AppColors.primary, // Keep same for consistency, or use darker
                      secondary: AppColors.accent,
                      surface: Color(0xFF1E1E1E), // Darker tile
                      onPrimary: Colors.white,
                      onSecondary: Colors.white,
                      onSurface: Colors.white,
                    ),
                    scaffoldBackgroundColor: Colors.black,
                    cardColor: const Color(0xFF1E1E1E),
                    textTheme: const TextTheme(
                      bodyLarge: TextStyle(color: Colors.white),
                      bodyMedium: TextStyle(color: Colors.white),
                    ),
                  ),
                  themeMode: themeMode,
                  locale: locale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en'), // English
                    Locale('or'), // Odia
                  ],
                  home: initSuccess ? const WelcomeScreen() : const ErrorScreen(),
                );
              },
            );
          },
        );
      },
    );
  }
}

// Simple error screen shown if initialization fails
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Initialization Failed',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Unable to set up app storage. Please restart the app or check device permissions.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                // Attempt to re-initialize Hive and user storage
                try {
                  await Hive.initFlutter();
                  Hive.registerAdapter(SavedLessonAdapter());
                  Hive.registerAdapter(UserAdapter());
                  await initializeUserStorage();
                  hiveInitNotifier.value = true;
                  print('Retry successful');
                } catch (e) {
                  print('Retry failed: $e');
                  hiveInitNotifier.value = false;
                }
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    NewDashboardScreen(),
    AchievementsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard),
            label: l10n.dashboard,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            label: l10n.achievements,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: l10n.profile,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.6),
        onTap: _onItemTapped,
      ),
    );
  }
}
