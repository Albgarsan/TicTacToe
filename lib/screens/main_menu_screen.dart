import 'package:flutter/material.dart';
import 'game_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final TextEditingController playerXController = TextEditingController();
  final TextEditingController playerOController = TextEditingController();

  void _startGame() {
    final playerX = playerXController.text.trim().isEmpty
        ? 'Player X'
        : playerXController.text.trim();
    final playerO = playerOController.text.trim().isEmpty
        ? 'Player O'
        : playerOController.text.trim();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(playerX: playerX, playerO: playerO),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TicTacToe')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter player names:',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: playerXController,
                  decoration: const InputDecoration(labelText: 'Player X'),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: playerOController,
                  decoration: const InputDecoration(labelText: 'Player O'),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007AFF),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Play'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}