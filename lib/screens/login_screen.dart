import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FilledButton(
                      onPressed: () async {
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('username', _nameController.text);
                        if (context.mounted) Navigator.of(context).pushReplacementNamed("/rooms");
                      },
                      child: const Text("Oyna"))),
            )
          ],
        ),
      ]),
    );
  }
}
