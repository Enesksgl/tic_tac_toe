import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/services/supabase_service.dart';

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
    supabaseService.listenRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rooms"),
        ),
        body: Obx(
          () => Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: supabaseService.rooms.map((room) => Text("${room.id!}${room.name!}")).toList()),
          ),
        ));
  }
}
