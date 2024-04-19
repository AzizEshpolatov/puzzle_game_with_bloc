import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/game_models.dart';
import '../screens/game/end_screen.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
      : super(
          GameState(
            currentQuestionIndex: 0,
            allQuestions: questions,
            trueCount: 0,
            enteredAnswer: "",
            letterList: const [],
          ),
        ) {
    on<LoadQuestionsEvent>(onInit);
    on<NextQuestionsEvent>(onNext);
    on<CollectEnteredLetterEvent>(onCollect);
    on<RemoveEvent>(onRemove);
  }

  onInit(LoadQuestionsEvent event, emit) {
    String answerText = questions[state.currentQuestionIndex].trueAnswer;

    emit(
      state.copyWith(
        allQuestions: questions,
        letterList: getOptionLetters(answerText),
      ),
    );
  }

  onRemove(RemoveEvent event, emit) {
    emit(
      state.copyWith(
        enteredAnswer: state.enteredAnswer.replaceAll(event.alphabet, ""),
      ),
    );
  }

  onNext(NextQuestionsEvent event, emit) {
    if (state.currentQuestionIndex < questions.length - 1) {
      int newQuestionIndex = state.currentQuestionIndex + 1;
      getOptionLetters(
          state.allQuestions[state.currentQuestionIndex].trueAnswer);
      emit(state.copyWith(currentQuestionIndex: newQuestionIndex));
      emit(
        state.copyWith(
          enteredAnswer: "",
          letterList:
              getOptionLetters(state.allQuestions[newQuestionIndex].trueAnswer),
        ),
      );
    } else {
      Navigator.pushAndRemoveUntil(
        event.context,
        MaterialPageRoute(
          builder: (context) => const EndScreen(),
        ),
        (route) => false,
      );
    }
  }

  onCollect(CollectEnteredLetterEvent event, emit) {
    String text = state.enteredAnswer;
    text += event.letter;
    emit(state.copyWith(enteredAnswer: text));
    if (state.enteredAnswer ==
        state.allQuestions[state.currentQuestionIndex].trueAnswer) {
      add(NextQuestionsEvent(event.context));
    } else if (state.enteredAnswer.length ==
        state.allQuestions[state.currentQuestionIndex].trueAnswer.length) {
      emit(
        state.copyWith(
          enteredAnswer: "",
        ),
      );
    }
  }
}

String alphabet = "qwertyuiopasdfghjklzxcvbnm";

List<String> getOptionLetters(String answerText) {
  int len = answerText.length;

  for (int i = 0; i < (12 - len); i++) {
    Random random = Random();
    int index = random.nextInt(26);
    answerText += alphabet[index];
  }
  List<String> letterList = answerText.split('');
  letterList.shuffle();
  debugPrint("LENGTH:${letterList.length}:$letterList");
  return letterList;
}

List<GameModels> questions = [
  GameModels(
    trueAnswer: "phone",
    images: [
      "https://images.pexels.com/photos/699122/pexels-photo-699122.jpeg?auto=compress&cs=tinysrgb&w=600",
      "https://images.pexels.com/photos/607812/pexels-photo-607812.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/9584336/pexels-photo-9584336.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
      "https://images.pexels.com/photos/5054358/pexels-photo-5054358.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ],
  ),
  GameModels(
    trueAnswer: "laptop",
    images: [
      "https://images.pexels.com/photos/18105/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/3822336/pexels-photo-3822336.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/3693732/pexels-photo-3693732.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ],
  ),
  GameModels(
    trueAnswer: "parij",
    images: [
      "https://images.pexels.com/photos/699466/pexels-photo-699466.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/3922749/pexels-photo-3922749.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/11901483/pexels-photo-11901483.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/8550015/pexels-photo-8550015.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ],
  ),
  GameModels(
    trueAnswer: "train",
    images: [
      "https://images.pexels.com/photos/72594/japan-train-railroad-railway-72594.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/14924424/pexels-photo-14924424.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/3993423/pexels-photo-3993423.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/3993423/pexels-photo-3993423.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ],
  ),
];
