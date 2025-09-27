import 'package:flutter/material.dart';

class WordPuzzleGame extends StatefulWidget {
  const WordPuzzleGame({super.key});

  @override
  _WordPuzzleGameState createState() => _WordPuzzleGameState();
}

class _WordPuzzleGameState extends State<WordPuzzleGame> {
  final List<String> words = ['apple', 'banana', 'cat', 'dog', 'elephant'];
  late String currentWord;
  late List<String> shuffledLetters;
  String userAnswer = '';

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    currentWord = (words..shuffle()).first;
    shuffledLetters = currentWord.split('')..shuffle();
    userAnswer = '';
  }

  void _onLetterTap(String letter) {
    setState(() {
      userAnswer += letter;
    });
  }

  void _onClear() {
    setState(() {
      userAnswer = '';
    });
  }

  void _onSubmit() {
    if (userAnswer.toLowerCase() == currentWord.toLowerCase()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Correct!'),
          content: Text('You spelled "$currentWord" correctly!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _startNewGame();
                });
              },
              child: const Text('Next Word'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Try again!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Puzzle Game'),
        backgroundColor: Colors.orange[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Arrange the letters to form a word:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              children: shuffledLetters
                  .map((letter) => ElevatedButton(
                        onPressed: () => _onLetterTap(letter),
                        child: Text(letter.toUpperCase()),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Text(
              userAnswer,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _onClear, child: const Text('Clear')),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: _onSubmit, child: const Text('Submit')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
