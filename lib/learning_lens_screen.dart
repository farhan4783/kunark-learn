// lib/learning_lens_screen.dart

// ignore: unused_import
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'app_colors.dart';

class LearningLensScreen extends StatefulWidget {
  const LearningLensScreen({super.key});

  @override
  State<LearningLensScreen> createState() => _LearningLensScreenState();
}

class _LearningLensScreenState extends State<LearningLensScreen> {
  // --- State Variables ---
  bool _isLoading = false;
  Uint8List? _imageBytes;
  String? _generatedContent;
  String? _error;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndAnalyzeImage(ImageSource source) async {
    setState(() {
      _isLoading = true;
      _generatedContent = null;
      _error = null;
      _imageBytes = null;
    });

    try {
      final XFile? image = await _picker.pickImage(source: source, imageQuality: 70, maxWidth: 800);
      if (image == null) {
        setState(() => _isLoading = false);
        return;
      }
      
      _imageBytes = await image.readAsBytes();
      
      // Now, generate the lesson from the image bytes
      await _generateLessonFromImage(_imageBytes!);

    } catch (e) {
      setState(() {
        _error = "Failed to pick or analyze image: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  Future<void> _generateLessonFromImage(Uint8List imageBytes) async {
    const apiKey = "YOUR_API_KEY_HERE"; // IMPORTANT: Use your Gemini API Key
    if (apiKey == "YOUR_API_KEY_HERE") {
       setState(() { _error = "API Key not set."; _isLoading = false; });
       return;
    }
    
    // Use the Gemini 1.5 Flash model which supports multimodal input
    final model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);

    // This is the multimodal prompt with text and image
    final prompt = TextPart("You are an expert teacher for the 'Konark Learn' app. Your audience is students in rural Odisha, India. Identify the object in this image and generate a simple, practical micro-lesson about it in Markdown format. Use relatable examples. The lesson must include these sections: ### Identification, ### Key Facts, ### Practical Use / Tip, and ### Summary.");
    
    final imagePart = DataPart('image/jpeg', imageBytes);

    final response = await model.generateContent([
      Content.multi([prompt, imagePart])
    ]);
    
    setState(() {
      _generatedContent = response.text;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Lens'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Image Display Area ---
            Container(
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
              ),
              child: _imageBytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(_imageBytes!, fit: BoxFit.cover),
                    )
                  : const Center(
                      child: Text('Take a photo or select an image', style: TextStyle(color: AppColors.muted)),
                    ),
            ),
            const SizedBox(height: 20),

            // --- Action Buttons ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                  onPressed: _isLoading ? null : () => _pickAndAnalyzeImage(ImageSource.camera),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                  onPressed: _isLoading ? null : () => _pickAndAnalyzeImage(ImageSource.gallery),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            // --- Results Area ---
            _buildResultsArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsArea() {
    if (_isLoading) {
      return const Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('AI is identifying and creating your lesson...'),
          ],
        ),
      );
    } else if (_error != null) {
      return Center(
        child: Text(_error!, style: const TextStyle(color: Colors.red)),
      );
    } else if (_generatedContent != null) {
      // Use the Markdown widget to display the formatted lesson
      return MarkdownBody(data: _generatedContent!);
    } else {
      return const Center(
        child: Text('Your AI-generated lesson will appear here.'),
      );
    }
  }
}