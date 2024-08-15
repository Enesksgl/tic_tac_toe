enum RoomStatus { CREATED, IN_GAME, COMPLETED }

enum Player { PLAYER_1, PLAYER_2 }

class Room {
  int? id;
  DateTime? createdAt;
  String? name, playerX, playerO, password;
  List<dynamic>? board = const [];
  Player? currentTurn = Player.PLAYER_1;
  RoomStatus? status = RoomStatus.CREATED;
  int boardLength = 3;

  Room(
    this.name,
    this.playerX,
    this.playerO, {
    this.id,
    this.createdAt,
    this.status = RoomStatus.CREATED,
    this.password,
    this.currentTurn = Player.PLAYER_1,
    this.boardLength = 3,
    this.board = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'player_X': playerX,
      'player_O': playerO,
      'board': board,
      'current_turn': currentTurn?.name,
      'status': status?.name,
      'password': password,
      'board_length': boardLength
    };
  }

  factory Room.fromJson(Map<dynamic, dynamic> json) {
    return Room(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        json["name"],
        json["player_X"],
        json["player_O"],
        currentTurn: Player.values.byName(json["current_turn"]),
        status: RoomStatus.values.byName(json["status"]),
        board: json["board"],
        password: json["password"],
        boardLength: json["board_length"]);
  }
}
