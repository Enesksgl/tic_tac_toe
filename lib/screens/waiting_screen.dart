import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset('lib/assets/tic-tac-toe-logo.png', fit: BoxFit.fitWidth, opacity: const AlwaysStoppedAnimation(0.1)),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator(),SizedBox(height: 30,), Text("Diğer oyuncu bekleniyor...",style: TextStyle(fontWeight: FontWeight.bold),)],
                    )]
        ),
      ),
    );
  }
}
