import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tic_tac_toe/screens/login_screen.dart';
import 'package:tic_tac_toe/screens/room_create_screen.dart';
import 'package:tic_tac_toe/screens/rooms_screen.dart';
import 'package:tic_tac_toe/screens/splash_screen.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://aqvqbcmvrslsvnqzilcp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFxdnFiY212cnNsc3ZucXppbGNwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM1NDQ1NDAsImV4cCI6MjAzOTEyMDU0MH0.bKxURrliC0-m6jJFNoR4m2Tf3wZIu7s523CMixp7L1g',
  );
  runApp(const MyApp());
}
final GlobalKey<NavigatorState> globalNavigator = GlobalKey<NavigatorState>(debugLabel: 'main');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: globalNavigator,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: "/",
      onUnknownRoute: (settings) => throw Exception('[Main Navigator] Unknown route: ${settings.name}'),
      routes: {
        '/': (c) => const SplashScreen(),
        '/login': (c) => const LoginScreen(),
        '/rooms': (c) => const RoomsScreen(),
        '/rooms/create': (c) => const RoomCreateScreen(),
      },
    );
  }
}

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Future<void> _incrementCounter() async {
    supabaseService.createRoom(Room("enes", "enes", "ahmet", "enes"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/