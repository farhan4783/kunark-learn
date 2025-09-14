// lib/quiz_loading_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:rural_learning_app/quiz_model.dart';
import 'app_colors.dart';
import 'geography_quiz_screen.dart'; // We will create this next

class QuizLoadingScreen extends StatefulWidget {
  const QuizLoadingScreen({super.key});

  @override
  State<QuizLoadingScreen> createState() => _QuizLoadingScreenState();
}

class _QuizLoadingScreenState extends State<QuizLoadingScreen> {
  @override
  void initState() {
    super.initState();
    _generateQuizQuestions();
  }

  Future<void> _generateQuizQuestions() async {
    const apiKey = "YOUR_API_KEY_HERE"; // Make sure to use your Gemini API Key
    if (apiKey == "YOUR_API_KEY_HERE") {
       // Handle API key missing error
      return;
    }
    final model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);

    // This is a very specific prompt to get the AI to return JSON
    const prompt = """
    You are a quiz master creating a fun and educational geography quiz.
    Generate a list of 5 multiple-choice questions about world geography for students in India.
    Provide the output in a valid JSON array format. Each object in the array must have:
    1. A "question" key with the question text.
    2. An "options" key with an array of 4 string options.
    3. An "answer" key with the text of the correct option.
    Do not include any text outside of the JSON array.
    """;

    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      
      // Clean up the response from the AI
      final text = response.text!.replaceAll('```json', '').replaceAll('```', '').trim();
      final unescape = HtmlUnescape();
      final decoded = jsonDecode(unescape.convert(text));
      
      final List<QuizQuestion> questions = (decoded as List)
          .map((item) => QuizQuestion.fromJson(item))
          .toList();

      // Navigate to the quiz screen with the generated questions
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => GeographyQuizScreen(questions: questions),
          ),
        );
      }
    } catch (e) {
      // Handle error, maybe show a dialog and pop back
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 20),
            Text(
              'Generating your GK Challenge...\nPlease wait.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
