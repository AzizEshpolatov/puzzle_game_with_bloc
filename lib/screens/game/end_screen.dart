import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_games_image/bloc/game_bloc.dart';
import 'package:puzzle_games_image/bloc/game_state.dart';
import 'package:puzzle_games_image/screens/game/game_screen.dart';

import '../../utils/size_utils.dart';

class EndScreen extends StatefulWidget {
  const EndScreen({super.key});

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  @override
  void initState() {
    context.read<GameBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return BlocBuilder<GameBloc, GameState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "The End Games",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const GameScreen();
                  }));
                },
                icon: const Icon(Icons.refresh_rounded)),
            const SizedBox(width: 10),
          ],
          backgroundColor: Colors.green,
        ),
        body: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: Image.network(
                "https://images.pexels.com/photos/3006228/pexels-photo-3006228.jpeg?auto=compress&cs=tinysrgb&w=600",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    });
  }
}
