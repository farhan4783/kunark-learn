import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// --- DATA MODELS ---

class GameQuestion {
  final String question;
  final List<dynamic> options;
  final dynamic answer;

  GameQuestion({required this.question, required this.options, required this.answer});
}

// --- MATH MONSTER BATTLE GAME ---

class MathMonsterBattleGame extends StatefulWidget {
  const MathMonsterBattleGame({super.key});

  @override
  State<MathMonsterBattleGame> createState() => _MathMonsterBattleGameState();
}

class _MathMonsterBattleGameState extends State<MathMonsterBattleGame> {
  @override
  Widget build(BuildContext context) {
    return const ClassSelectionScreen();
  }
}

// --- AI GENERATED QUESTION BANK ---
// A comprehensive set of questions for each class from 6 to 12.
// Note: For complex math symbols, we use Unicode or plain text (e.g., ^ for power).
// For true LaTeX rendering, a package like 'flutter_math_fork' would be needed.

final Map<int, List<GameQuestion>> allQuestions = {
  6: [
    GameQuestion(question: "What is (-15) + 8?", options: [-7, 7, -23, 23], answer: -7),
    GameQuestion(question: "Solve for x: x - 5 = 12", options: [7, 17, -7, -17], answer: 17),
    GameQuestion(question: "What is 3/5 as a percentage?", options: ["30%", "50%", "60%", "75%"], answer: "60%"),
    GameQuestion(question: "Find the perimeter of a rectangle with length 10cm and width 5cm.", options: ["15cm", "30cm", "50cm", "25cm"], answer: "30cm"),
  ],
  7: [
    GameQuestion(question: "Calculate 15% of 300.", options: [30, 45, 50, 60], answer: 45),
    GameQuestion(question: "Solve for y: 3y + 7 = 28", options: [5, 6, 7, 8], answer: 7),
    GameQuestion(question: "The sum of angles in a triangle is always...", options: ["90°", "180°", "270°", "360°"], answer: "180°"),
    GameQuestion(question: "What is 0.5 * 24?", options: [10, 12, 14, 16], answer: 12),
  ],
  8: [
    GameQuestion(question: "What is the square root of 144?", options: [10, 11, 12, 13], answer: 12),
    GameQuestion(question: "Expand (a + b)²", options: ["a²+b²", "a²-2ab+b²", "a²+2ab+b²", "2a+2b"], answer: "a²+2ab+b²"),
    GameQuestion(question: "What is 5³ (5 cubed)?", options: [15, 25, 125, 53], answer: 125),
    GameQuestion(question: "Find the simple interest on ₹1000 at 10% for 2 years.", options: ["₹100", "₹200", "₹1200", "₹20"], answer: "₹200"),
  ],
  9: [
    GameQuestion(question: "The point (-4, 6) lies in which quadrant?", options: ["I", "II", "III", "IV"], answer: "II"),
    GameQuestion(question: "What is the degree of the polynomial 5x⁴ - 3x² + 7?", options: [2, 3, 4, 5], answer: 4),
    GameQuestion(question: "Area of a circle with radius 7cm? (Use π = 22/7)", options: ["154 cm²", "77 cm²", "44 cm²", "144 cm²"], answer: "154 cm²"),
    GameQuestion(question: "Which of the following is an irrational number?", options: ["√4", "√9", "√7", "0.5"], answer: "√7"),
  ],
  10: [
    GameQuestion(question: "Find the roots of the quadratic equation x² - 9 = 0.", options: ["3, 3", "-3, -3", "3, -3", "9, -9"], answer: "3, -3"),
    GameQuestion(question: "What is the value of sin(30°)?", options: ["1", "1/2", "√3/2", "0"], answer: "1/2"),
    GameQuestion(question: "What is the next term in the A.P.: 4, 7, 10, 13, ...?", options: [15, 16, 17, 18], answer: 16),
    GameQuestion(question: "If a pair of dice is thrown, what is the probability of getting a sum of 8?", options: ["1/6", "5/36", "1/12", "1/9"], answer: "5/36"),
  ],
  11: [
    GameQuestion(question: "d/dx (x³) = ?", options: ["3x", "x²/2", "3x²", "x³"], answer: "3x²"),
    GameQuestion(question: "What is the value of 5! (5 factorial)?", options: [25, 120, 720, 100], answer: 120),
    GameQuestion(question: "If A = {1, 2} and B = {2, 3}, what is A ∪ B?", options: ["{2}", "{1, 3}", "{1, 2, 3}", "{}"], answer: "{1, 2, 3}"),
    GameQuestion(question: "What is the value of i² (where i is an imaginary number)?", options: [1, -1, "i", "-i"], answer: -1),
  ],
  12: [
    GameQuestion(question: "∫ 3x² dx = ?", options: ["x³ + C", "6x + C", "x²/3 + C", "3x³ + C"], answer: "x³ + C"),
    GameQuestion(question: "Find the determinant of the matrix [[2, 1], [4, 5]].", options: [6, 10, 14, 4], answer: 6),
    GameQuestion(question: "What is the probability of drawing a king from a deck of 52 cards?", options: ["1/13", "1/26", "1/52", "4/13"], answer: "1/13"),
    GameQuestion(question: "A vector from origin (0,0) to point (3,4) has a magnitude of:", options: [3, 4, 5, 7], answer: 5),
  ],
};

// --- SCREENS ---

class ClassSelectionScreen extends StatelessWidget {
  const ClassSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _buildClassButton({required String title, required int classNum}) {
      return Container(
        width: 280,
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameScreen(classNumber: classNum),
              ),
            );
          },
          child: Text(title, style: const TextStyle(fontSize: 20, color: Colors.white)),
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://static.vecteezy.com/system/resources/previews/055/144/842/non_2x/cartoon-animals-in-a-lush-green-jungle-scene-photo.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8))
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "📚 Select Your Class 📚",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Use a ListView for a scrollable list of classes
                SizedBox(
                  height: 300, // Constrain the height of the list
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      _buildClassButton(title: "Class 6", classNum: 6),
                      _buildClassButton(title: "Class 7", classNum: 7),
                      _buildClassButton(title: "Class 8", classNum: 8),
                      _buildClassButton(title: "Class 9", classNum: 9),
                      _buildClassButton(title: "Class 10", classNum: 10),
                      _buildClassButton(title: "Class 11", classNum: 11),
                      _buildClassButton(title: "Class 12", classNum: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final int classNumber;

  const GameScreen({super.key, required this.classNumber});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // --- State Variables ---
  late List<GameQuestion> _currentClassQuestions;
  int _currentQuestionIndex = 0;
  String _feedbackText = "";
  Color _feedbackColor = Colors.transparent;
  bool _isNextButtonVisible = false;
  bool _isSessionOver = false;
  double _monsterOpacity = 1.0;
  String _monsterImageAsset = 'assets/images/monster1.png';

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMusicPlaying = true;

  @override
  void initState() {
    super.initState();
    _currentClassQuestions = allQuestions[widget.classNumber]!;
    // Randomize monster appearance
    _monsterImageAsset = (widget.classNumber % 2 == 0)
        ? 'assets/images/monster2.png'
        : 'assets/images/monster1.png';
    _playMusic();
  }

  void _playMusic() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
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
    if (_isNextButtonVisible) return;

    final correctAnswer = _currentClassQuestions[_currentQuestionIndex].answer;
    setState(() {
      if (selectedAnswer.toString() == correctAnswer.toString()) {
        _feedbackText = "✅ Correct! You hit the monster!";
        _feedbackColor = Colors.green.shade700;
        _monsterOpacity = 0.5;
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
      if (_currentQuestionIndex < _currentClassQuestions.length) {
        _resetForNewQuestion();
      } else {
        // All questions for the class are finished
        _isSessionOver = true;
        _feedbackText = "Great job, Math Hero!";
      }
    });
  }

  void _resetForNewQuestion() {
    _feedbackText = "";
    _monsterOpacity = 1.0;
    _isNextButtonVisible = false;
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GameQuestion? currentQuestion =
        _isSessionOver ? null : _currentClassQuestions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Class ${widget.classNumber} Battle"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://static.vecteezy.com/system/resources/previews/055/144/842/non_2x/cartoon-animals-in-a-lush-green-jungle-scene-photo.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
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
                      offset: const Offset(0, 8))
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "⚔️ Math Monster Battle 👾",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/images/hero.png', width: 100),
                      if (!_isSessionOver)
                        AnimatedOpacity(
                          opacity: _monsterOpacity,
                          duration: const Duration(milliseconds: 300),
                          child: Image.asset(_monsterImageAsset, width: 100),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (_isSessionOver)
                    Text(
                      "🎉 Class ${widget.classNumber} Complete! 🎉",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                      textAlign: TextAlign.center,
                    )
                  else ...[
                    Text(
                      currentQuestion!.question,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    ...currentQuestion.options.map((option) {
                      return Container(
                        width: 250,
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
                  Text(
                    _feedbackText,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _feedbackColor),
                    textAlign: TextAlign.center,
                  ),
                  if (_isNextButtonVisible) ...[
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Next ➡️",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleMusic,
        tooltip: 'Toggle Music',
        child: Icon(_isMusicPlaying ? Icons.volume_up : Icons.volume_off),
      ),
    );
  }
}
