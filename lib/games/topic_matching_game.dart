import 'package:flutter/material.dart';

class TopicMatchingGame extends StatefulWidget {
  final Map<String, String> pairs;

  const TopicMatchingGame({super.key, required this.pairs});

  @override
  _TopicMatchingGameState createState() => _TopicMatchingGameState();
}

class _TopicMatchingGameState extends State<TopicMatchingGame> {
  late List<String> leftItems;
  late List<String> rightItems;
  Map<String, String> matchedPairs = {};
  String? selectedLeft;

  @override
  void initState() {
    super.initState();
    leftItems = widget.pairs.keys.toList()..shuffle();
    rightItems = widget.pairs.values.toList()..shuffle();
  }

  void _selectLeft(String item) {
    setState(() {
      selectedLeft = item;
    });
  }

  void _selectRight(String item) {
    if (selectedLeft == null) return;
    if (widget.pairs[selectedLeft] == item) {
      setState(() {
        matchedPairs[selectedLeft!] = item;
        selectedLeft = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Try again!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (matchedPairs.length == widget.pairs.length) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Topic Matching Game'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Congratulations! You matched all pairs!'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    matchedPairs.clear();
                    leftItems.shuffle();
                    rightItems.shuffle();
                  });
                },
                child: const Text('Play Again'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Topic Matching Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ListView(
                children: leftItems.map((item) {
                  final isSelected = item == selectedLeft;
                  final isMatched = matchedPairs.containsKey(item);
                  return ListTile(
                    title: Text(item),
                    tileColor: isSelected ? Colors.blue[100] : null,
                    enabled: !isMatched,
                    onTap: () => _selectLeft(item),
                  );
                }).toList(),
              ),
            ),
            const VerticalDivider(),
            Expanded(
              child: ListView(
                children: rightItems.map((item) {
                  final isMatched = matchedPairs.containsValue(item);
                  return ListTile(
                    title: Text(item),
                    enabled: !isMatched,
                    onTap: () => _selectRight(item),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
