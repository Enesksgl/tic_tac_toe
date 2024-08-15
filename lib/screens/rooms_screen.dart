import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';
import 'package:tic_tac_toe/main.dart';
import 'package:tic_tac_toe/services/supabase_service.dart';
import 'package:tic_tac_toe/widgets/room_tile.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  final supabaseService = Get.put(SupabaseService());

  @override
  void initState() {
    super.initState();
    supabaseService.listenRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Oyun Odaları"),
              Row(
                children: [
                  const Icon(Icons.person),
                  Text(GameController.username!),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => globalNavigator.currentState!.pushNamed("/rooms/create"),
          icon: const Icon(Icons.add),
          label: const Text("Oda oluştur"),
        ),
        body: Obx(
          () => SingleChildScrollView(
              child: Column(
                   children: supabaseService.rooms.map((room) => RoomTile(room: room)).toList())),
        ));
  }
}
