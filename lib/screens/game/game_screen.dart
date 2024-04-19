import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_games_image/screens/game/widgets/letter_items.dart';
import '../../bloc/game_bloc.dart';
import '../../bloc/game_event.dart';
import '../../bloc/game_state.dart';
import '../../utils/size_utils.dart';
import '../widgets/image_items.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    context.read<GameBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return Stack(
            children: [
              Image.network(
                "https://images.pexels.com/photos/5059020/pexels-photo-5059020.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    50.getH(),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        ...List.generate(
                          state.allQuestions[state.currentQuestionIndex].images
                              .length,
                          (index) {
                            return ImageItems(
                              image: state
                                  .allQuestions[state.currentQuestionIndex]
                                  .images[index],
                            );
                          },
                        ),
                      ],
                    ),
                    20.getH(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...List.generate(
                          state.allQuestions[state.currentQuestionIndex]
                              .trueAnswer.length,
                          (index) {
                            return InkWell(
                              onTap: () {
                                context.read<GameBloc>().add(
                                      RemoveEvent(state.enteredAnswer[index]),
                                    );
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.only(right: 10.w, bottom: 10.h),
                                width: 40,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: index < state.enteredAnswer.length
                                      ? Colors.blue
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    index < state.enteredAnswer.length
                                        ? state.enteredAnswer[index]
                                        : "",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          state.letterList.length,
                          (index) {
                            return alphabetButton(
                              title: state.letterList[index],
                              onPressed: () {
                                context.read<GameBloc>().add(
                                      CollectEnteredLetterEvent(
                                        state.letterList[index],
                                        context,
                                      ),
                                    );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    15.getH(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
