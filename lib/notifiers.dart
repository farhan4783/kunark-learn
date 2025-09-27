import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'user_model.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);

final ValueNotifier<Locale> localeNotifier = ValueNotifier<Locale>(const Locale('en'));

// User authentication state
final ValueNotifier<User?> userNotifier = ValueNotifier<User?>(null);

// Users storage box
Box<User>? usersBox;

// Initialize Hive box and load user data
Future<void> initializeUserStorage() async {
  int retryCount = 0;
  const maxRetries = 2;

  while (retryCount < maxRetries) {
    try {
      usersBox = await Hive.openBox<User>('users');

      // Load the current user if exists
      final currentUser = usersBox!.get('current_user');
      if (currentUser != null) {
        userNotifier.value = currentUser;
      }
      return; // Success, exit
    } catch (e) {
      print('Failed to initialize usersBox (attempt ${retryCount + 1}): $e');
      retryCount++;
      if (retryCount < maxRetries) {
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }
  print('Failed to initialize usersBox after $maxRetries retries');
  usersBox = null;
}

// Save user to Hive
Future<void> saveUser(User user) async {
  if (usersBox == null || !usersBox!.isOpen) {
    await initializeUserStorage();
  }
  if (usersBox != null && usersBox!.isOpen) {
    await usersBox!.put('current_user', user);
    userNotifier.value = user;
  } else {
    throw Exception('Failed to open usersBox for saving user');
  }
}

// Clear user data
Future<void> clearUser() async {
  if (usersBox == null || !usersBox!.isOpen) {
    await initializeUserStorage();
  }
  if (usersBox != null && usersBox!.isOpen) {
    await usersBox!.delete('current_user');
    userNotifier.value = null;
  } else {
    // If box can't be opened, just clear notifier
    userNotifier.value = null;
  }
}
