import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
       final navigator = Navigator.of(context);
      if (!connectivityResult.contains(ConnectivityResult.none)) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? username = prefs.getString('username');
        if (username != null && username != "") {
          navigator.pushReplacementNamed("/rooms");
        } else {
          navigator.pushReplacementNamed("/login");
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("İnternet Bağlantısı Yok"),
              content: const Text("Lütfen internet bağlantınızı kontrol edin."),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Tamam"),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(height: MediaQuery.of(context).size.height, color: Colors.white, child: const Center(child: CircularProgressIndicator())),
      ],
    ));
  }
}
