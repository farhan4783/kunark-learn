import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

// Data model for our questions to make the code cleaner and type-safe
class GameQuestion {
  final String question;
  final List<dynamic> options;
  final dynamic answer;

  GameQuestion({required this.question, required this.options, required this.answer});
}

class MathMonsterBattleGame extends StatefulWidget {
  const MathMonsterBattleGame({super.key});

  @override
  State<MathMonsterBattleGame> createState() => _MathMonsterBattleGameState();
}

class _MathMonsterBattleGameState extends State<MathMonsterBattleGame> {
  // --- Game Data ---
  final Map<int, List<GameQuestion>> _levels = {
    1: [
      GameQuestion(question: "5 + 3 = ?", options: [7, 8, 9, 10], answer: 8),
      GameQuestion(question: "12 + 7 = ?", options: [18, 19, 20, 21], answer: 19),
    ],
    2: [
      GameQuestion(question: "1/2 + 1/2 = ?", options: ["1", "2", "1/4"], answer: "1"),
      GameQuestion(question: "3/4 - 1/4 = ?", options: ["1/2", "1/4", "2/4"], answer: "1/2"),
    ],
    3: [
      GameQuestion(question: "6 + 2 × 2 = ?", options: [10, 12, 8], answer: 10),
      GameQuestion(question: "9 ÷ 3 + 4 = ?", options: [6, 7, 8], answer: 7),
    ]
  };

  // --- State Variables ---
  int _currentLevel = 1;
  int _currentQuestionIndex = 0;
  String _feedbackText = "";
  Color _feedbackColor = Colors.transparent;
  bool _isNextButtonVisible = false;
  bool _isGameOver = false;
  double _monsterOpacity = 1.0;
  String _monsterImageAsset = 'assets/images/monster1.png';

  // --- Audio Player ---
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMusicPlaying = true;

  @override
  void initState() {
    super.initState();
    _playMusic();
  }

  void _playMusic() async {
    // Set the release mode to loop for continuous playback
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    // Play the audio from assets
    await _audioPlayer.play(AssetSource('audio/bg-music.mp3'));
  }

  void _toggleMusic() {
    setState(() {
      if (_isMusicPlaying) {
        _audioPlayer.pause();
      } else {
        _audioPlayer.resume();
      }
      _isMusicPlaying = !_isMusicPlaying;
    });
  }

  void _checkAnswer(dynamic selectedAnswer) {
    // Prevent answering again until the next question
    if (_isNextButtonVisible) return;

    final correctAnswer = _levels[_currentLevel]![_currentQuestionIndex].answer;
    setState(() {
      if (selectedAnswer == correctAnswer) {
        _feedbackText = "✅ Correct! You hit the monster!";
        _feedbackColor = Colors.green.shade700;
        _monsterOpacity = 0.5; // Monster gets hit
        _isNextButtonVisible = true;
      } else {
        _feedbackText = "❌ Wrong! Monster attacks!";
        _feedbackColor = Colors.red;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      // Check if there are more questions in the current level
      if (_currentQuestionIndex < _levels[_currentLevel]!.length) {
        _resetForNewQuestion();
      } else {
        // Go to the next level
        _currentLevel++;
        _currentQuestionIndex = 0;
        // Check if there are more levels
        if (_levels.containsKey(_currentLevel)) {
          _resetForNewQuestion();
          // Update monster for the new level
          _monsterImageAsset = _currentLevel == 2
              ? 'assets/images/monster2.png'
              : 'assets/images/monster1.png';
        } else {
          // Game over
          _isGameOver = true;
          _feedbackText = "Great job, Math Hero!";
        }
      }
    });
  }

  void _resetForNewQuestion() {
    _feedbackText = "";
    _monsterOpacity = 1.0;
    _isNextButtonVisible = false;
  }

  String _getLevelTitle() {
    switch (_currentLevel) {
      case 1:
        return "Level 1: Addition";
      case 2:
        return "Level 2: Fractions";
      case 3:
        return "Level 3: Mixed Problems";
      default:
        return "";
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Clean up the audio player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current question object, if the game is not over
    GameQuestion? currentQuestion =
        _isGameOver ? null : _levels[_currentLevel]![_currentQuestionIndex];

    return Scaffold(
      body: Container(
        // Set background image like in the CSS
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://static.vecteezy.com/system/resources/previews/055/144/842/non_2x/cartoon-animals-in-a-lush-green-jungle-scene-photo.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView( // Prevents overflow on smaller screens
            child: Container(
              width: 450,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "⚔️ Math Monster Battle 👾",
                    style: GoogleFonts.comicNeue(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  if (!_isGameOver)
                    Text(
                      _getLevelTitle(),
                      style: GoogleFonts.comicNeue(
                        fontSize: 18,
                      ),
                    ),
                  const SizedBox(height: 20),

                  // Battle Scene
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/images/hero.png', width: 100),
                      if (!_isGameOver)
                      AnimatedOpacity(
                        opacity: _monsterOpacity,
                        duration: const Duration(milliseconds: 300),
                        child: Image.asset(_monsterImageAsset, width: 100),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Game Content
                  if (_isGameOver)
                    Text(
                      "🎉 You defeated all monsters!",
                      style: GoogleFonts.comicNeue(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      textAlign: TextAlign.center,
                    )
                  else ...[
                    Text(
                      currentQuestion!.question,
                      style: GoogleFonts.comicNeue(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    // Options
                    ...currentQuestion.options.map((option) {
                      return Container(
                        width: 220,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          onPressed: () => _checkAnswer(option),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            option.toString(),
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                  ],

                  const SizedBox(height: 10),
                  // Feedback Text
                  Text(
                    _feedbackText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _feedbackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // Next Button (conditionally visible)
                  if (_isNextButtonVisible) ...[
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Next ➡️", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
      // Music Toggle Button
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleMusic,
        tooltip: 'Toggle Music',
        child: Icon(_isMusicPlaying ? Icons.volume_up : Icons.volume_off),
      ),
    );
  }
}
