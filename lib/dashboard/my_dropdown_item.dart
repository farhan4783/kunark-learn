// lib/dashboard/my_dropdown_item.dart

import 'package:flutter/material.dart';
import 'package:rural_learning_app/app_colors.dart';
// ignore: unused_import
import 'package:rural_learning_app/main.dart'; // Import to use AppColors

class MyDropdownButtonItem extends StatelessWidget {
  final String current;
  final List<String> data;
  final ValueChanged<String?> onChanged;

  const MyDropdownButtonItem({
    super.key,
    required this.current,
    required this.data,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: current,
      underline: Container(), // Removes the underline
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
      items: data
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
    );
  }
}