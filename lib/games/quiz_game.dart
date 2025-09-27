import 'package:flutter/material.dart';

class QuizGame extends StatefulWidget {
  const QuizGame({super.key});

  @override
  _QuizGameState createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  final List<Map<String, Object>> questions = [
    {
      'question': 'What is the capital of India?',
      'options': ['Delhi', 'Mumbai', 'Kolkata', 'Chennai'],
      'answer': 'Delhi',
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Earth', 'Mars', 'Jupiter', 'Saturn'],
      'answer': 'Mars',
    },
    {
      'question': 'What is 5 + 7?',
      'options': ['10', '11', '12', '13'],
      'answer': '12',
    },
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  bool answered = false;
  String? selectedOption;

  void _selectOption(String option) {
    if (answered) return;
    setState(() {
      selectedOption = option;
      answered = true;
      if (option == questions[currentQuestionIndex]['answer']) {
        score++;
      }
    });
  }

  void _nextQuestion() {
    if (!answered) return;
    setState(() {
      currentQuestionIndex++;
      answered = false;
      selectedOption = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= questions.length) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Game'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Quiz Completed!', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              Text('Your score: $score / ${questions.length}', style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentQuestionIndex = 0;
                    score = 0;
                    answered = false;
                    selectedOption = null;
                  });
                },
                child: const Text('Restart Quiz'),
              ),
            ],
          ),
        ),
      );
    }

    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Game'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question['question'] as String,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            ...((question['options'] as List<String>).map((option) {
              final isSelected = option == selectedOption;
              final isCorrect = option == question['answer'];
              Color? optionColor;
              if (answered) {
                if (isSelected) {
                  optionColor = isCorrect ? Colors.green : Colors.red;
                } else if (isCorrect) {
                  optionColor = Colors.green;
                }
              }
              return Card(
                color: optionColor,
                child: ListTile(
                  title: Text(option),
                  onTap: () => _selectOption(option),
                ),
              );
            }).toList()),
            const Spacer(),
            ElevatedButton(
              onPressed: answered ? _nextQuestion : null,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
