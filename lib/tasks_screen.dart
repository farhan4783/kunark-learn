// lib/tasks_screen.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'task_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // --- Dummy Data for Tasks ---
  final List<Task> allTasks = const [
    Task(title: 'Soil pH Test Project', subject: 'Chemistry', type: TaskType.project, status: TaskStatus.todo, points: 100),
    Task(title: 'Lesson 1: Atoms Quiz', subject: 'Chemistry', type: TaskType.quiz, status: TaskStatus.todo, points: 20),
    Task(title: 'Write a Business Plan', subject: 'Business', type: TaskType.project, status: TaskStatus.todo, points: 150),
    Task(title: 'Chapter 1 Summary', subject: 'Language', type: TaskType.summary, status: TaskStatus.completed, points: 30),
    Task(title: 'First Aid Quiz', subject: 'Medicine', type: TaskType.quiz, status: TaskStatus.completed, points: 25),
    Task(title: 'Marketing Slogan Challenge', subject: 'Business', type: TaskType.project, status: TaskStatus.todo, points: 50),
  ];
  // --- End of Dummy Data ---

  List<Task> get _todoTasks => allTasks.where((task) => task.status == TaskStatus.todo).toList();
  List<Task> get _completedTasks => allTasks.where((task) => task.status == TaskStatus.completed).toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.muted,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'TO-DO'),
            Tab(text: 'COMPLETED'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TaskList(tasks: _todoTasks),
          _TaskList(tasks: _completedTasks),
        ],
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  final List<Task> tasks;
  const _TaskList({required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.done_all, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text(
              'No tasks here.\nGood job!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: AppColors.muted),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return _TaskCard(task: tasks[index]);
      },
    );
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;
  const _TaskCard({required this.task});

  IconData _getIconForType(TaskType type) {
    switch (type) {
      case TaskType.project:
        return Icons.construction;
      case TaskType.quiz:
        return Icons.quiz;
      case TaskType.summary:
        return Icons.edit_document;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Icon(_getIconForType(task.type), color: AppColors.primary),
        ),
        title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(task.subject, style: const TextStyle(color: AppColors.muted)),
        ),
        trailing: Text(
          '${task.points} pts',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.accent),
        ),
        onTap: () {
          // Placeholder for navigating to a task detail screen
        },
      ),
    );
  }
}