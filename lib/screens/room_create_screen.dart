import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';
import 'package:tic_tac_toe/models/room.dart';
import 'package:tic_tac_toe/services/supabase_service.dart';

class RoomCreateScreen extends StatefulWidget {
  const RoomCreateScreen({super.key});

  @override
  State<RoomCreateScreen> createState() => _RoomCreateScreenState();
}

class _RoomCreateScreenState extends State<RoomCreateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final supabaseService = Get.put(SupabaseService());


  bool isLocked = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = "${GameController.username!} Adlı Oyuncunun Odası";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Oda oluştur"),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    labelText: "Oda adı",
                    hintText: "Oda adı",
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6.0)), gapPadding: 4)),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.length < 3) {
                    return "En az 3 karakter girin";
                  }
                  return null;
                },
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Switch(
                    value: isLocked,
                    onChanged: (value) => setState(() {
                          isLocked = value;
                          _passwordController.text = "";
                        })),
                const SizedBox(width: 10),
                const Text("Odayı şifrele")
              ],
            ),
          ),
          isLocked
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        labelText: "Şifre",
                        hintText: "Şifre",
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6.0)), gapPadding: 4)),
                  ))
              : const SizedBox.shrink(),
          //TODO : BACKGROUND COLOR
          FilledButton(
              onPressed: () {
                supabaseService.createRoom(
                    Room(_nameController.text, GameController.username, null, GameController.username, password: _passwordController.text));
                navigator?.pushReplacementNamed("/waiting");
              },
              child: const Text("Oluştur"))
        ],
      ),
    );
  }
}
