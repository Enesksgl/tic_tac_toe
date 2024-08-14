import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tic_tac_toe/models/room.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;
  var rooms = <Room>[].obs;
  static final SupabaseService _service = SupabaseService._internal();

  factory SupabaseService() {
    return _service;
  }
  SupabaseService._internal();

  void createRoom(Room room) async {
    await supabase.from('rooms').insert(room);
  }

  void listenRoom() async {
    supabase.from('rooms').stream(primaryKey: ["id"]).listen((data) => rooms.addAll(data.map((d) => Room.fromJson(d)).toList()));
  }
}
