import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tres en Raya',
      home: const TicTacToeGame(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String? winner;

  void _handleTap(int index) {
    if (board[index] == '' && winner == null) {
      setState(() {
        board[index] = currentPlayer;
        winner = _checkWinner();
        if (winner == null && board.contains('')) {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
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

    for (var condition in winConditions) {
      final a = condition[0], b = condition[1], c = condition[2];
      if (board[a] != '' && board[a] == board[b] && board[a] == board[c]) {
        return board[a];
      }
    }

    if (!board.contains('')) return 'Empate';
    return null;
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final shortestSide = size.shortestSide;
    final boardSize = shortestSide * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tres en Raya'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              winner == null
                  ? 'Turno de: $currentPlayer'
                  : (winner == 'Empate' ? '¡Empate!' : 'Ganador: $winner'),
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: boardSize,
              height: boardSize,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _handleTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(
                          fontSize: boardSize / 6,
                          fontWeight: FontWeight.bold,
                          color: board[index] == 'X'
                              ? Colors.blue
                              : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _resetGame,
              child: const Text('Reiniciar'),
            ),
          ],
        ),
      ),
    );
  }
}
