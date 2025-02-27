import 'package:flutter/material.dart';

import '../data/questions.dart';
import '../screens/quiz/quiz_question_screen.dart';
import '../screens/quiz/quiz_result_screen.dart';
import '../screens/quiz/quiz_start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';
  DateTime startTime = DateTime.now();

  void switchScreen(DateTime start) {
    setState(() {
      activeScreen = 'questions-screen';
      startTime = start;
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
      startTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
        startTime: startTime,
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
        startTime: startTime,
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 122, 70, 212),
                Color.fromARGB(255, 71, 38, 128),
              ],
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
