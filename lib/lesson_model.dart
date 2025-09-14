// lib/lesson_model.dart

class Lesson {
  final int number;
  final String title;
  final String subtitle;
  final int hours;
  final bool isCurrent;

  Lesson({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.hours,
    this.isCurrent = false,
  });
}

// Dummy data to populate our list
final List<Lesson> lessons = [
  Lesson(number: 1, title: 'Introduction to Agriculture', subtitle: 'Basics of farming', hours: 88),
  Lesson(number: 2, title: 'Soil Management', subtitle: 'Understanding soil types', hours: 95),
  Lesson(number: 3, title: 'Crop Cycles', subtitle: 'From seed to harvest', hours: 53, isCurrent: true),
  Lesson(number: 4, title: 'Pest Control', subtitle: 'Modern techniques', hours: 99),
  Lesson(number: 5, title: 'Water Conservation', subtitle: 'Efficient irrigation', hours: 74),
  Lesson(number: 6, title: 'Farm Technology', subtitle: 'Using new tools', hours: 90),
  Lesson(number: 7, title: 'Livestock Basics', subtitle: 'Animal husbandry', hours: 65),
];