import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rural_learning_app/app_colors.dart';

class NewDashboardScreen extends StatelessWidget {
  const NewDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.eco, color: AppColors.primary, size: isSmallScreen ? 24 : 30),
            const SizedBox(width: 8),
            Text(
              'Konark Learn',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: isSmallScreen ? 18 : 22,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: AppColors.primary, size: isSmallScreen ? 24 : 30),
            onPressed: () {
              // TODO: Implement profile action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
        child: Column(
          children: [
            // Row 1: Progress and Course Info
            isSmallScreen
              ? Column(
                  children: [
                    const _ProgressCard(),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        _InfoCard(
                          icon: Icons.agriculture,
                          text: 'Current Course: Sustainable Farming Practices',
                          backgroundColor: AppColors.accent,
                        ),
                        const SizedBox(height: 12),
                        _InfoCard(
                          icon: Icons.notes,
                          text: 'Next Lesson: Crop Rotation Techniques',
                          backgroundColor: AppColors.accent,
                          hasArrow: true,
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 2, child: _ProgressCard()),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          _InfoCard(
                            icon: Icons.agriculture,
                            text: 'Current Course: Sustainable Farming Practices',
                            backgroundColor: AppColors.accent,
                          ),
                          const SizedBox(height: 16),
                          _InfoCard(
                            icon: Icons.notes,
                            text: 'Next Lesson: Crop Rotation Techniques',
                            backgroundColor: AppColors.accent,
                            hasArrow: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            const SizedBox(height: 16),
            // Row 2: Available Courses and Community Forum
            isSmallScreen
              ? Column(
                  children: [
                    _GridActionCard(
                      title: 'Available Courses',
                      backgroundColor: AppColors.accent,
                      items: [
                        _ActionItem(icon: Icons.grass, label: 'Organic Agriculture'),
                        _ActionItem(icon: Icons.pets, label: 'Livestock Management'),
                        _ActionItem(icon: Icons.business_center, label: 'Agri-Business Basics'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const _CommunityForumCard(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _GridActionCard(
                        title: 'Available Courses',
                        backgroundColor: AppColors.accent,
                        items: [
                          _ActionItem(icon: Icons.grass, label: 'Organic Agriculture'),
                          _ActionItem(icon: Icons.pets, label: 'Livestock Management'),
                          _ActionItem(icon: Icons.business_center, label: 'Agri-Business Basics'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(flex: 1, child: _CommunityForumCard()),
                  ],
                ),
            const SizedBox(height: 16),
            // Row 3: Learning Resources and Calendar
            isSmallScreen
              ? Column(
                  children: [
                    _GridActionCard(
                      title: 'Learning Resources',
                      backgroundColor: AppColors.accent,
                      items: [
                        _ActionItem(icon: Icons.play_circle_fill, label: 'Video Tutorials'),
                        _ActionItem(icon: Icons.download_for_offline, label: 'Downloadable Guides'),
                        _ActionItem(icon: Icons.lightbulb, label: 'Expert Q&A'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const _CalendarEventsCard(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _GridActionCard(
                        title: 'Learning Resources',
                        backgroundColor: AppColors.accent,
                        items: [
                          _ActionItem(icon: Icons.play_circle_fill, label: 'Video Tutorials'),
                          _ActionItem(icon: Icons.download_for_offline, label: 'Downloadable Guides'),
                          _ActionItem(icon: Icons.lightbulb, label: 'Expert Q&A'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(flex: 1, child: _CalendarEventsCard()),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}

// Widget for the "My Progress" card
class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.accent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('My Progress', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primary)),
            const SizedBox(height: 16),
            CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 10.0,
              percent: 0.75,
              center: Text(
                "75%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.primary),
              ),
              progressColor: Colors.white,
              backgroundColor: AppColors.primary.withOpacity(0.2),
              circularStrokeCap: CircularStrokeCap.round,
            ),
            const SizedBox(height: 10),
            Text(
              'Course Completion',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.primary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for the small info cards like "Current Course"
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final bool hasArrow;

  const _InfoCard({
    required this.icon,
    required this.text,
    required this.backgroundColor,
    this.hasArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ),
            if (hasArrow) ...[
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 16),
            ]
          ],
        ),
      ),
    );
  }
}

// Reusable data holder for action items
class _ActionItem {
  final IconData icon;
  final String label;
  _ActionItem({required this.icon, required this.label});
}

// Widget for cards with a grid of icon-buttons
class _GridActionCard extends StatelessWidget {
    final String title;
    final List<_ActionItem> items;
    final Color backgroundColor;

    const _GridActionCard({
        required this.title,
        required this.items,
        required this.backgroundColor
    });

    @override
    Widget build(BuildContext context) {
        return Card(
            color: backgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
                        Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primary)),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          alignment: WrapAlignment.spaceAround,
                          children: items.map((item) => SizedBox(
                            width: 80,
                            child: _IconWithLabel(icon: item.icon, label: item.label),
                          )).toList(),
                        ),
                    ],
                ),
            ),
        );
    }
}


// A small icon and a label, used in several cards
class _IconWithLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconWithLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white.withOpacity(0.3),
          child: Icon(icon, size: 28, color: AppColors.primary),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.primary, fontSize: 12),
        ),
      ],
    );
  }
}

// Widget for the "Community Forum" card
class _CommunityForumCard extends StatelessWidget {
  const _CommunityForumCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.tile,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Community Forum', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primary)),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.chat_bubble_outline, color: AppColors.primary, size: 30),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Join the discussion\nCreate new post',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5, fontSize: 13, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// Widget for the "Calendar & Events" card
class _CalendarEventsCard extends StatelessWidget {
  const _CalendarEventsCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.accent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Calendar & Events', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primary)),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, color: AppColors.primary, size: 30),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Workshop: Nov 15\nField Trip: Dec 3',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primary, height: 1.5, fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
