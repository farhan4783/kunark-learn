// lib/task_model.dart

// ignore: unused_import
import 'package:flutter/material.dart';

// Enums to define the type and status of a task
enum TaskType { project, quiz, summary }
enum TaskStatus { todo, completed }

class Task {
  final String title;
  final String subject;
  final TaskType type;
  final TaskStatus status;
  final int points;

  const Task({
    required this.title,
    required this.subject,
    required this.type,
    required this.status,
    required this.points,
  });
}