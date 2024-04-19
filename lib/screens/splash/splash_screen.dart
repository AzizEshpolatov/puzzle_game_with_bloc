import 'package:flutter/material.dart';
import 'package:puzzle_games_image/screens/game/game_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const GameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            "https://images.pexels.com/photos/5059020/pexels-photo-5059020.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const Center(
            child: Text(
              "Welcome to Puzzle",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
