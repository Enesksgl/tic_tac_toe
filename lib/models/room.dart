enum RoomStatus { CREATED, IN_GAME, COMPLETED }

class Room {
  int? id;
  DateTime? createdAt;
  String? name, playerX, playerY, currentTurn, password;
  List<dynamic>? board = const [];

  RoomStatus? status =RoomStatus.CREATED ;

  Room(this.name, this.playerX, this.playerY, this.currentTurn,
      {this.id,
      this.createdAt,
      this.status =RoomStatus.CREATED,
      this.password,
      this.board = const [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""]
      ]});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'player_X': playerX,
      'player_Y': playerY,
      'board': board,
      'current_turn': currentTurn,
      'status': status?.name,
      'password': password,
    };
  }

  factory Room.fromJson(Map<dynamic, dynamic> json) {
    return Room(
      id:json["id"],
      createdAt: DateTime.parse(json["created_at"]),
      json["name"],
      json["player_X"],
      json["player_Y"],
      json["current_turn"],
      status: RoomStatus.values.byName(json["status"]),
      board: json["board"],
      password: json["password"]
    );
  }
}
