// lib/game_model.dart

import 'package:flutter/material.dart';

class GameInfo {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const GameInfo({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}