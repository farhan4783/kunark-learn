// lib/geography_quiz_screen.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'quiz_model.dart';

// --- DATA MODELS ---


// --- MAIN QUIZ SCREEN ---
class GeographyQuizScreen extends StatefulWidget {
  final List<QuizQuestion> questions;
  const GeographyQuizScreen({super.key, required this.questions});

  @override
  State<GeographyQuizScreen> createState() => _GeographyQuizScreenState();
}

class _GeographyQuizScreenState extends State<GeographyQuizScreen> {
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  final List<String?> _userAnswers = [];
  bool _answered = false;

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        _userAnswers.add(_selectedAnswer);
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _answered = false;
      });
    } else {
      // End of quiz
      _userAnswers.add(_selectedAnswer);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => QuizResultScreen(
            questions: widget.questions,
            userAnswers: _userAnswers,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentQuestionIndex + 1}/${widget.questions.length}'),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Question Text
            Text(
              question.question,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            // Options
            ...question.options.map((option) {
              bool isSelected = _selectedAnswer == option;
              bool isCorrect = question.answer == option;
              Color color = Colors.grey.shade200;

              if (_answered) {
                if (isCorrect) {
                  color = Colors.green.shade100;
                } else if (isSelected) {
                  color = Colors.red.shade100;
                }
              }

              return GestureDetector(
                onTap: _answered ? null : () => setState(() {
                  _selectedAnswer = option;
                  _answered = true;
                }),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Text(option, style: const TextStyle(fontSize: 16)),
                ),
              );
            }).toList(),
            const Spacer(),
            // Next Button
            ElevatedButton(
              onPressed: _answered ? _nextQuestion : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                _currentQuestionIndex == widget.questions.length - 1
                    ? 'Finish'
                    : 'Next',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- RESULTS SCREEN ---
class QuizResultScreen extends StatelessWidget {
  final List<QuizQuestion> questions;
  final List<String?> userAnswers;

  const QuizResultScreen({
    super.key,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    int correctAnswers = 0;
    for (int i = 0; i < questions.length; i++) {
      if (questions[i].answer == userAnswers[i]) {
        correctAnswers++;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.grey.shade100,
            child: Text(
              'You scored $correctAnswers / ${questions.length}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                final userAnswer = userAnswers[index];
                final bool isCorrect = question.answer == userAnswer;
                return Card(
                  color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Q: ${question.question}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Your answer: $userAnswer'),
                        Text('Correct answer: ${question.answer}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Back to Games'),
            ),
          )
        ],
      ),
    );
  }
}