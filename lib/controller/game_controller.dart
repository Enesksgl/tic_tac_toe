import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/models/room.dart';

class GameController extends GetxController {
  static String? username = "";
  Player currentPlayer = Player.PLAYER_1;
  var status = ''.obs;
  var room = Room(null, null, null).obs;

  static final GameController _controller = GameController._internal();

  factory GameController() {
    return _controller;
  }

  GameController._internal();

  Future<dynamic> showGameFinishDialog(BuildContext context, bool winner) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(winner ? "KAZANDIN" : "KAYBETTİN"),
            actions: [
              TextButton(
                child: const Text("TAMAM"),
                onPressed: () => navigator?.pushReplacementNamed("/rooms"),
              ),
            ],
          );
        });
  }

  Future<bool> boardControl() async {
    var board = room.value.board!;
    final List<List<int>> winPatterns = _generateWinPatterns();

    for (var pattern in winPatterns) {
      final String sign = board[pattern[0]];
      if (sign != '' && pattern.every((index) => board[index] == sign)) {
        await showGameFinishDialog(navigator!.context, sign == convertPlayerToSign(currentPlayer));
        room.value = Room(null, null, null, board: List.filled(room.value.boardLength * room.value.boardLength, ""));
        return true;
      }
    }

    if (!board.contains('')) {
      room.value.board = List.filled(room.value.boardLength * room.value.boardLength, "");
    }
    return false;
  }

  List<List<int>> _generateWinPatterns() {
    final List<List<int>> winPatterns = [];
    int boardLength = room.value.boardLength;

    for (int i = 0; i < boardLength; i++) {
      List<int> rowPattern = [];
      List<int> colPattern = [];
      for (int j = 0; j < boardLength; j++) {
        rowPattern.add(i * boardLength + j); // Satır için
        colPattern.add(j * boardLength + i); // Sütun için
      }
      winPatterns.add(rowPattern);
      winPatterns.add(colPattern);
    }

    // Çapraz kazanma kombinasyonlarını ekle
    List<int> cross1 = [];
    List<int> cross2 = [];
    for (int i = 0; i < boardLength; i++) {
      cross1.add(i * boardLength + i); // Sol üstten sağ alta
      cross2.add(i * boardLength + (boardLength - 1 - i)); // Sağ üstten sol alta
    }
    winPatterns.add(cross1);
    winPatterns.add(cross2);

    return winPatterns;
  }

  void clickControl(int index) {
    if (room.value.board![index] == "") {
      if (room.value.currentTurn == currentPlayer &&
          GameController.username == (currentPlayer == Player.PLAYER_1 ? room.value.playerX : room.value.playerO)) {
        room.value.board![index] = convertPlayerToSign(currentPlayer);
        room.value.currentTurn = currentPlayer == Player.PLAYER_1 ? Player.PLAYER_2 : Player.PLAYER_1;
      }
    }
  }

  void setRoomAndPlayerY(Room r) {
    r.playerO = username;
    room.value = r;
    currentPlayer = Player.PLAYER_2;
  }

  String convertPlayerToSign(Player currentPlayer) {
    return currentPlayer == Player.PLAYER_1 ? "X" : "O";
  }
}
