import 'dart:math';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final String playerX;
  final String playerO;

  const GameScreen({super.key, required this.playerX, required this.playerO});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> board = List.filled(9, '');
  String currentPlayer = Random().nextBool() ? 'X' : 'O';
  String? winner;

  int scoreX = 0;
  int scoreO = 0;
  int draws = 0;

  void _handleTap(int index) {
    if (board[index] == '' && winner == null) {
      setState(() {
        board[index] = currentPlayer;
        winner = _checkWinner();
        if (winner == null && board.contains('')) {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        } else if (winner != null) {
          if (winner == 'X') {
            scoreX++;
          } else if (winner == 'O') {
            scoreO++;
          } else if (winner == 'Draw') {
            draws++;
          }
        }
      });
    }
  }

  String? _checkWinner() {
    const winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var c in winConditions) {
      if (board[c[0]] != '' &&
          board[c[0]] == board[c[1]] &&
          board[c[0]] == board[c[2]]) {
        return board[c[0]];
      }
    }

    if (!board.contains('')) return 'Draw';
    return null;
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      winner = null;
    });
  }

  String getCurrentPlayerName() {
    return currentPlayer == 'X' ? widget.playerX : widget.playerO;
  }

  String getWinnerName() {
    if (winner == 'X') return widget.playerX;
    if (winner == 'O') return widget.playerO;
    return 'Draw';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TicTacToe'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                winner == null
                    ? "${getCurrentPlayerName()}'s turn ($currentPlayer)"
                    : (winner == 'Draw'
                        ? 'Draw!'
                        : 'Winner: ${getWinnerName()} ($winner)'),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GridView.builder(
                      itemCount: 9,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => _handleTap(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[700]!),
                            color: const Color(0xFF2C2C2E),
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                board[index],
                                style: TextStyle(
                                  fontSize: 100,
                                  fontWeight: FontWeight.bold,
                                  color: board[index] == 'X'
                                      ? const Color(0xFF8B0000)
                                      : board[index] == 'O'
                                          ? const Color(0xFF005F73)
                                          : Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${widget.playerX} (X): $scoreX   ${widget.playerO} (O): $scoreO   Draws: $draws',
                      style: const TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    ElevatedButton(
                      onPressed: _resetGame,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007AFF),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Restart game'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
