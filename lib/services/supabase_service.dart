import 'dart:async';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';
import 'package:tic_tac_toe/models/room.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;
  var rooms = <Room>[].obs;
  static final SupabaseService _service = SupabaseService._internal();
  final gameController = Get.put(GameController());

  factory SupabaseService() {
    return _service;
  }

  SupabaseService._internal();

  Future<Room> createRoom(Room room) async {
    var data = await supabase.from('rooms').insert(room).select();
    return Room.fromJson(data.first);
  }

  Future<Room> updateRoom(Room room) async {
    var data = await supabase.from('rooms').update(room.toJson()).eq("id", room.id!).select();
    return Room.fromJson(data.first);
  }

  void listenRooms() async {
    supabase.from('rooms').stream(primaryKey: ["id"]).order("id", ascending: false).listen((data) {
          rooms.clear();
          rooms.addAll(data.map((d) => Room.fromJson(d)).toList());
        });
    rooms.shuffle();
  }

  void listenCreatedRoom(Room r) async {
    gameController.room.value = r;
    late var subscription;
    subscription = supabase.from('rooms').stream(primaryKey: ["id"]).eq("id", r.id!).listen((data) async {
          if (gameController.room.value.status != RoomStatus.COMPLETED) {
            var room = Room.fromJson(data.first);
            if (room.playerO != null && room.status == RoomStatus.CREATED && room.playerX == GameController.username) {
              navigator?.pushReplacementNamed("/game");
              room.status = RoomStatus.IN_GAME;
              gameController.room.value = await updateRoom(room);
            } else {
              gameController.room.value = room;
              if (await gameController.boardControl()) {
                room.status = RoomStatus.COMPLETED;
                gameController.room.value = await updateRoom(room);
                subscription.cancel();
              }
            }
          }
        });
  }
}
