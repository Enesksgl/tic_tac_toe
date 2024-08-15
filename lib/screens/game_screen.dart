import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';
import 'package:tic_tac_toe/models/room.dart';
import 'package:tic_tac_toe/services/supabase_service.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final gameController = Get.put(GameController());
  final supabaseService = Get.put(SupabaseService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Column(
        children: [
          const SizedBox(height: 70),
          Center(
              child: Text(
                  "Oyun sırası: ${gameController.room.value.currentTurn == Player.PLAYER_1 ? gameController.room.value.playerX : gameController.room.value.playerO}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return buildGridTile(index);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("X", style: GoogleFonts.gloriaHallelujah(textStyle: const TextStyle(fontSize: 90))),
                  Text(gameController.room.value.playerX?? "", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
              Column(
                children: [
                  Text("O", style: GoogleFonts.gloriaHallelujah(textStyle: const TextStyle(fontSize: 90))),
                  Text(gameController.room.value.playerO ?? "", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }

  Widget buildGridTile(int index) {
    return GestureDetector(
      onTap: () async {
        gameController.clickControl(index);
        gameController.room.value = await supabaseService.updateRoom(gameController.room.value);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Center(
          child: Text(
            gameController.room.value.board![index],
            style: GoogleFonts.gloriaHallelujah(textStyle: const TextStyle(fontSize: 90)),
          ),
        ),
      ),
    );
  }
}
