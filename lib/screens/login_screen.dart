import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/game_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/assets/tic-tac-toe-logo.png', fit: BoxFit.fitWidth, opacity: const AlwaysStoppedAnimation(0.1)),
                Image.asset('lib/assets/tic-tac-toe-logo.png', fit: BoxFit.fitWidth, opacity: const AlwaysStoppedAnimation(0.1)),
                Image.asset('lib/assets/tic-tac-toe-logo.png', fit: BoxFit.fitWidth, opacity: const AlwaysStoppedAnimation(0.1)),
              ],
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tic Tac Toe",
              style: GoogleFonts.gloriaHallelujah(textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Align(alignment: Alignment.bottomRight, child: Text("Developed by EK", style: GoogleFonts.gloriaHallelujah())),
            ),
            const SizedBox(height: 50),
            const Text(
              "Lütfen oyuncu adınızı giriniz.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        labelText: "Oyuncu adı",
                        hintText: "Oyuncu adı",
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6.0)), gapPadding: 4)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.length < 3) {
                        return "En az 3 karakter girin";
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() {}),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('username', _nameController.text);
                          GameController.username = _nameController.text;
                         navigator!.pushReplacementNamed("/rooms");
                        }
                      },
                      child: const Text("Oyna"))),
            )
          ],
        ),
      ]),
    );
  }
}
