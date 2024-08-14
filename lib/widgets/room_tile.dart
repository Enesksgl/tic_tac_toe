import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/room.dart';

class RoomTile extends StatefulWidget {
  final Room room;

  const RoomTile({super.key, required this.room});

  @override
  State<RoomTile> createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
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

  @override
  Widget build(BuildContext context) {
    var isLocked = widget.room.password != null && widget.room.password != "";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      child: Card(
        color: widget.room.status == RoomStatus.COMPLETED
            ? Colors.black12
            : isLocked
                ? Colors.yellow.shade300
                : null,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.room.name!, style: Theme.of(context).textTheme.headlineSmall),
                  isLocked ? const Icon(Icons.lock) : const SizedBox()
                ],
              ),
              Row(
                children: [const Icon(Icons.person), Text(widget.room.playerX!), const Spacer(), Text(statusHandler(widget.room.status!))],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
