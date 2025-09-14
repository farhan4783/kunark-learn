// lib/generated_lesson_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'app_colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'saved_lesson_model.dart';

class GeneratedLessonScreen extends StatefulWidget {
  final String topic;
  const GeneratedLessonScreen({super.key, required this.topic});

  @override
  State<GeneratedLessonScreen> createState() => _GeneratedLessonScreenState();
}

class _GeneratedLessonScreenState extends State<GeneratedLessonScreen> {
  bool _isLoading = true;
  String? _generatedContent;
  String? _error;

  @override
  void initState() {
    super.initState();
    _generateLesson();
  }

  Future<void> _generateLesson() async {
    // IMPORTANT: Make sure your API key is correctly set in chat_screen.dart
    // or manage it in a more secure way. For now, we'll hardcode it here.
    const apiKey = "AIzaSyDrigIkz5ZzPXz8hPc0UVhEg7uIt4ZBHyY";
    if (apiKey == "YOUR_API_KEY_HERE") {
      setState(() {
        _error = "API Key not set. Please add your Gemini API key.";
        _isLoading = false;
      });
      return;
    }
    final model =
        GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);

    // This is the "prompt" that tells the AI what to do.
    // A detailed prompt gives better results.
    final prompt = """
      You are an expert teacher creating content for a mobile app called 'Rural Learning App'.
      Your audience is students in rural India, so use clear, simple English and provide relatable, real-world examples.

      Generate a complete lesson on the topic: "${widget.topic}".

      The lesson must have the following sections, using Markdown for formatting:
      
      ### Introduction
      (A brief, engaging overview of the topic.)
      
      ### Key Concepts
      (Explain the 2-3 most important ideas in simple terms using bullet points.)
      
      ### Real-World Example
      (Provide a practical example, ideally related to farming, nature, or daily life in a village.)
      
      ### Summary
      (Concisely summarize the lesson in a few sentences.)
      
      ### Quick Quiz
      (Provide 3 multiple-choice questions with 4 options each to test understanding. Mark the correct answer with an asterisk (*) at the end of the correct option.)
    """;

    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      setState(() {
        _generatedContent = response.text;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Failed to generate lesson: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        // vvv ADD THIS 'actions' SECTION vvv
        actions: [
          IconButton(
            icon: const Icon(Icons.download_for_offline_outlined),
            onPressed: _generatedContent == null
                ? null
                : () async {
                    // Save the lesson to the Hive database
                    final box =
                        await Hive.openBox<SavedLesson>('saved_lessons');
                    final lesson = SavedLesson(
                        topic: widget.topic, content: _generatedContent!);
                    await box.put(
                        lesson.topic, lesson); // Using topic as a unique key

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Lesson saved for offline access!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Generating your lesson with AI...'),
          ],
        ),
      );
    } else if (_error != null) {
      return Center(
        child: Text(_error!, style: const TextStyle(color: Colors.red)),
      );
    } else if (_generatedContent != null) {
      // The Markdown widget beautifully renders the AI's response
      return Markdown(data: _generatedContent!);
    } else {
      return const Center(child: Text('No content available.'));
    }
  }
}
