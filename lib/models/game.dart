class Game {
  final String playerX;
  final String playerO;
  final String winner;
  final DateTime date;

  Game({
    required this.playerX,
    required this.playerO,
    required this.winner,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'playerX': playerX,
    'playerO': playerO,
    'winner': winner,
    'date': date.toIso8601String(),
  };

  static Game fromJson(Map<String, dynamic> json) => Game(
    playerX: json['playerX'],
    playerO: json['playerO'],
    winner: json['winner'],
    date: DateTime.parse(json['date']),
  );
}
