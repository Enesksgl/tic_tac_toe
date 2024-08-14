import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GameController extends GetxController {
  static String? username = "";
  final supabase = Supabase.instance.client;
  var board = List.generate(3, (_) => List.generate(3, (_) => '')).obs;
  var currentPlayer = ''.obs;
  var status = ''.obs;

}