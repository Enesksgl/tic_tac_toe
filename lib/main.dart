import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tic_tac_toe/models/room.dart';
import 'package:tic_tac_toe/services/supabase_service.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://aqvqbcmvrslsvnqzilcp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFxdnFiY212cnNsc3ZucXppbGNwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM1NDQ1NDAsImV4cCI6MjAzOTEyMDU0MH0.bKxURrliC0-m6jJFNoR4m2Tf3wZIu7s523CMixp7L1g',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final supabaseService =Get.put(SupabaseService());
  @override
  void initState() {
    super.initState();
    supabaseService.listenRoom();
  }

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
      body: Obx(
          ()=> Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: supabaseService.rooms.map((room) => Text("${room.id!}${room.name!}")).toList()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
