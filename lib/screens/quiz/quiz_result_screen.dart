import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/screens/HomeScreen/Courses.dart';
import 'package:quiz_app/screens/quiz/quiz_menu.dart';

import '../../constant.dart';
import '../../models/generate_quiz.dart';
import 'component/sumary_result.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
    required this.results,
  });

  final void Function() onRestart;
  final List<String> chosenAnswers;
  final List<Result> results;


  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'questions_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = getSummaryData().where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;
    final startTime = DateTime.now();
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            QuestionsSummary(getSummaryData()),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(width: 2, color: k3),
                fixedSize: Size(150, 40)
              ),
              icon: const Icon(Icons.restart_alt),
              onPressed: onRestart,
              label: const Text('Restart Quiz!'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(width: 2, color: k3),
                  fixedSize: Size(150, 40)
              ),
              icon: const Icon(Icons.undo),
              onPressed: (){
                results.add(Result(
                    numCorrect: numCorrectQuestions,
                    numTotal: numTotalQuestions,
                    timeTaken: duration)
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Courses(results : results),
                        )
                );
              },
              label: const Text('Save Result'),
            ),
          ],
        ),
      ),
    );
  }
}
