import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';
import 'package:tic_tac_toe/models/room.dart';
import 'package:tic_tac_toe/services/supabase_service.dart';

class RoomTile extends StatefulWidget {
  final Room room;

  const RoomTile({super.key, required this.room});

  @override
  State<RoomTile> createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
  final gameController = Get.put(GameController());
  final supabaseService = Get.put(SupabaseService());

  String statusHandler(RoomStatus status) {
    switch (status) {
      case RoomStatus.CREATED:
        return "Oyuncu bekleniyor...";

      case RoomStatus.IN_GAME:
        return "Oyun başladı.";

      case RoomStatus.COMPLETED:
        return "Oyun tamamlandı.";
    }
  }

  Color cardColor(RoomStatus status) {
    switch (status) {
      case RoomStatus.CREATED:
        return Colors.white70;

      case RoomStatus.IN_GAME:
        return Colors.white30;

      case RoomStatus.COMPLETED:
        return Colors.black12;
    }
  }

  Future<dynamic> showPasswordDialog(BuildContext context, Room room) {
    final TextEditingController _passwordController = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Şifre Gir"),
            content: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    labelText: "Şifre",
                    hintText: "Şifre",
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6.0)), gapPadding: 4)),
              ),
            ),
            actions: [
              TextButton(
                child: const Text("TAMAM"),
                onPressed: () => Navigator.pop(context, room.password == _passwordController.text),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var isLocked = widget.room.password != null && widget.room.password != "";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      child: InkWell(
        onTap: () async {
          if (!isLocked || await showPasswordDialog(navigator!.context, widget.room)) {
            if (widget.room.status == RoomStatus.CREATED) {
              gameController.setRoomAndPlayerY(widget.room);
              await supabaseService.updateRoom(gameController.room.value);
              supabaseService.listenCreatedRoom(widget.room);
              navigator?.pushNamed("/game");
            }
          }
        },
        child: Card(
          color: isLocked && widget.room.status != RoomStatus.COMPLETED ? Colors.yellow.shade300 : cardColor(widget.room.status!),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(widget.room.name!, style: Theme.of(context).textTheme.headlineSmall)),
                    isLocked ? const Icon(Icons.lock) : const SizedBox()
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.person),
                    Text(widget.room.playerX!, overflow: TextOverflow.ellipsis),
                    const Spacer(),
                    Text(statusHandler(widget.room.status!))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
