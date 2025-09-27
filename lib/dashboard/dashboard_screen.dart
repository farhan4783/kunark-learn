import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rural_learning_app/app_colors.dart';
import 'package:rural_learning_app/task_model.dart';
import 'package:rural_learning_app/dashboard/my_dropdown_item.dart';

class NewDashboardScreen extends StatefulWidget {
  const NewDashboardScreen({super.key});

  @override
  State<NewDashboardScreen> createState() => _NewDashboardScreenState();
}

class _NewDashboardScreenState extends State<NewDashboardScreen> {
  final List<Task> tasks = [
    const Task(title: 'Soil pH Test Project', subject: 'Chemistry', type: TaskType.project, status: TaskStatus.todo, points: 100, progress: 0.6),
    const Task(title: 'Lesson 1: Atoms Quiz', subject: 'Chemistry', type: TaskType.quiz, status: TaskStatus.todo, points: 20, progress: 0.2),
    const Task(title: 'Write a Business Plan', subject: 'Business', type: TaskType.project, status: TaskStatus.todo, points: 150, progress: 0.9),
  ];

  // Simulate real-time updates with a timer or stream (to be implemented)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          MyDropdownButtonItem(
            current: 'Overall',
            data: const ['Overall', 'Monthly', 'Weekly'],
            onChanged: (value) {
              // TODO: Implement filtering logic and update UI accordingly
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Overall Progress Chart ---
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: _buildOverallProgress(),
              ),
              const SizedBox(height: 24),

              // --- Pending Projects Section ---
              _buildSectionTitle('Pending Tasks & Projects'),
              const SizedBox(height: 16),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tasks.length,
                  padding: const EdgeInsets.only(left: 16),
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return _buildProjectCard(
                      title: task.title,
                      description: task.subject,
                      daysLeft: (10 - (task.progress * 10)).toInt(),
                      progress: task.progress,
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // --- Additional Sections (Shuffle and add more widgets as needed) ---
              _buildSectionTitle('Upcoming Events'),
              const SizedBox(height: 16),
              _buildUpcomingEvents(),

              const SizedBox(height: 24),

              _buildSectionTitle('Recent Activities'),
              const SizedBox(height: 16),
              _buildRecentActivities(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    // TODO: Implement real-time data fetching and update state
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Update tasks or other data here
    });
  }

  Widget _buildOverallProgress() {
    return CircularPercentIndicator(
      radius: 80.0,
      lineWidth: 12.0,
      percent: 0.65,
      center: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '65%',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0, color: AppColors.primary),
          ),
          Text('Completed', style: TextStyle(fontSize: 14, color: AppColors.muted)),
        ],
      ),
      progressColor: AppColors.primary,
      backgroundColor: AppColors.tile,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(onPressed: () {}, child: const Text('View All')),
        ],
      ),
    );
  }

  Widget _buildProjectCard({
    required String title,
    required String description,
    required int daysLeft,
    required double progress,
  }) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(description, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$daysLeft days left', style: const TextStyle(fontSize: 12, color: AppColors.primary)),
                Text('${(progress * 100).toInt()}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            LinearPercentIndicator(
              percent: progress,
              lineHeight: 8,
              backgroundColor: AppColors.tile,
              progressColor: AppColors.accent,
              barRadius: const Radius.circular(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingEvents() {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.tile,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text('No upcoming events'),
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.tile,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text('No recent activities'),
      ),
    );
  }
}
