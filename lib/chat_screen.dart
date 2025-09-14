// lib/chat_screen.dart - UPDATED FOR KID-FRIENDLY UI AND MICKEY MOUSE

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemChrome
import 'package:google_generative_ai/google_generative_ai.dart';
import 'app_colors.dart'; // Make sure this import is correct

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  late final GenerativeModel _model;
  late final ChatSession _chat;

  // IMPORTANT: Replace with your actual Gemini API Key
  // For production apps, store this securely (e.g., environment variables)
  static const _apiKey = "AIzaSyDrigIkz5ZzPXz8hPc0UVhEg7uIt4ZBHyY";

  @override
  void initState() {
    super.initState();
    // Hide status bar for a more immersive look, and then restore it on dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    if (_apiKey.isEmpty || _apiKey == "YOUR_API_KEY_HERE") {
      // Handle the case where the API key is not set.
      // For a real app, you might show an error message or disable AI features.
      _messages.add(
        const ChatMessage(
          text: "Oops! My AI brain isn't connected. Please check your API Key!",
          isUser: false,
          sender: "System",
          avatarImage: 'assets/images/mickey_mouse_welcome.png', // Use Mickey for system messages too
        ),
      );
    } else {
      _model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: _apiKey);
      _chat = _model.startChat();
      // Add the initial welcome message from Mickey Mouse
      _messages.add(
        const ChatMessage(
          text: "Hi there, future genius! I'm Mickey, your friendly AI Helper. What exciting things do you want to learn about today?",
          isUser: false,
          sender: "Mickey",
          avatarImage: 'assets/images/mickey_mouse_welcome.png',
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    // Restore status bar when leaving the chat screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _handleSubmitted(String text) async {
    if (text.isEmpty) return;
    _textController.clear();

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true, sender: "You"));
    });

    _scrollToBottom();

    if (_apiKey.isEmpty || _apiKey == "YOUR_API_KEY_HERE") {
      // If API key is not set, don't try to send message to AI
      return;
    }

    try {
      final response = await _chat.sendMessage(Content.text(text));
      final String? aiResponse = response.text;

      if (aiResponse != null) {
        setState(() {
          _messages.add(ChatMessage(text: aiResponse, isUser: false, sender: "Mickey", avatarImage: 'assets/images/mickey_mouse_welcome.png'));
        });
      } else {
        setState(() {
          _messages.add(ChatMessage(text: "I didn't quite catch that. Could you please rephrase?", isUser: false, sender: "Mickey", avatarImage: 'assets/images/mickey_mouse_welcome.png'));
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(text: "Oops! Something went wrong: $e", isUser: false, sender: "Mickey", avatarImage: 'assets/images/mickey_mouse_welcome.png'));
      });
      print("Error sending message to AI: $e");
    } finally {
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mickey Your AI Helper', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: AppColors.primary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(hintText: "Ask Mickey anything!"),
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
    required this.sender,
    this.avatarImage, // Optional avatar image for non-user messages
  });

  final String text;
  final bool isUser;
  final String sender;
  final String? avatarImage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isUser && avatarImage != null) // Show avatar for AI messages
            CircleAvatar(
              backgroundImage: AssetImage(avatarImage!),
              radius: 20,
              backgroundColor: Colors.transparent, // Background to blend with image
            ),
          if (!isUser && avatarImage == null) // Fallback for AI if no specific image
            CircleAvatar(
              backgroundColor: AppColors.accent,
              child: Text(sender[0], style: const TextStyle(color: Colors.white)),
            ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isUser ? sender : sender, // Keep sender for both
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isUser ? AppColors.primary : AppColors.accent,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: isUser ? AppColors.primary.withOpacity(0.8) : AppColors.tile.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15.0),
                      topRight: const Radius.circular(15.0),
                      bottomLeft: isUser ? const Radius.circular(15.0) : const Radius.circular(0.0),
                      bottomRight: isUser ? const Radius.circular(0.0) : const Radius.circular(15.0),
                    ),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isUser ? Colors.white : theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          if (isUser) // Show avatar for user messages
            CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text(sender[0], style: const TextStyle(color: Colors.white)),
            ),
        ],
      ),
    );
  }
}