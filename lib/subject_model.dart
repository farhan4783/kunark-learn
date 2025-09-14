// lib/subject_model.dart

import 'package:flutter/material.dart';

class Subject {
  final String name;
  final IconData icon;

  Subject({required this.name, required this.icon});
}

// Dummy data for our subjects page
final List<Subject> subjects = [
  Subject(name: 'English', icon: Icons.work_outline),
  Subject(name: 'Chemistry', icon: Icons.science_outlined),
  Subject(name: 'Biology', icon: Icons.local_hospital_outlined),
  Subject(name: 'Language', icon: Icons.language),
  Subject(name: 'Physics', icon: Icons.rocket_launch_outlined),
  Subject(name: 'Maths', icon: Icons.calculate_outlined),
];
