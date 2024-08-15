import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
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
  int boardLength = 3;
  final supabaseService = Get.put(SupabaseService());
  final gameController = Get.put(GameController());


  bool isLocked = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = "${GameController.username!} Adlı Oyuncunun Odası";
  }

  Color _currentColor = Colors.white;

  void _pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Arkaplan rengi seç"),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _currentColor,
            onColorChanged: (Color color) {
              setState(() {
                _currentColor = color;
              });
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("Tamam"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                Text("Şifre", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(width: 20),
                isLocked
                    ? Expanded(
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(12),
                              labelText: "Şifre",
                              hintText: "Şifre",
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6.0)), gapPadding: 4)),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Arkaplan rengi: ', style: Theme.of(context).textTheme.titleMedium),
                ElevatedButton(
                  onPressed: () => _pickColor(context),
                  child: Row(
                    children: [
                      Container(width: 60, height: 30, color: _currentColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Tablo boyutu: ", style: Theme.of(context).textTheme.titleMedium),
                Text("${boardLength}x$boardLength", style: Theme.of(context).textTheme.titleLarge),
                Card(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => setState(() {
                          final newValue = boardLength - 1;
                          boardLength = newValue.clamp(3, 9);
                        }),
                      ),
                      NumberPicker(
                        axis: Axis.horizontal,
                        value: boardLength,
                        itemWidth: 20,
                        itemHeight: 30,
                        minValue: 3,
                        maxValue: 9,
                        step: 1,
                        haptics: true,
                        onChanged: (value) => setState(() => boardLength = value),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => setState(() {
                          final newValue = boardLength + 1;
                          boardLength = newValue.clamp(3, 9);
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          FilledButton(
              onPressed: () async {
                var room = await supabaseService.createRoom(Room(_nameController.text, GameController.username, null,
                    backgroundColor: _currentColor.toHexString(),
                    board: List.filled(boardLength * boardLength, ""),
                    boardLength: boardLength,
                    password: _passwordController.text));
                supabaseService.listenCreatedRoom(room);
                gameController.currentPlayer = Player.PLAYER_1;
                navigator?.pushReplacementNamed("/waiting");
              },
              child: const Text("Oluştur"))
        ],
      ),
    );
  }
}
